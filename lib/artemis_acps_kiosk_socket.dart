import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:artemis_acps/artemis_acps_contoller.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'classes/artemis_acps_aea_command_class.dart';
import 'classes/artemis_acps_kiosk_class.dart';
import 'classes/artemis_acps_kiosk_config_class.dart';
import 'classes/artemis_kiosk_status_class.dart';

class AcpsKioskUtil {
  final ArtemisAcpsController controller;

  late HubConnection _hubConnection =
      HubConnectionBuilder().withUrl('www.artemis.com', options: HttpConnectionOptions(skipNegotiation: true, transport: HttpTransportType.WebSockets, headers: MessageHeaders(), accessTokenFactory: () async => jsonEncode({}))).build();

  String? get devId => _config?.deviceId;
  String al = "ZZ";

  String? get connectedAddress => _connectAddress;
  String? _connectAddress;
  ArtemisAcpsKioskConfig? _config;

  Map<String, ArtemisAcpsAeaCommand> inProgressAeaActions = {};
  final Map<String, Completer<ArtemisAcpsAeaResponse>> _pendingAeaResponses = {};

  Map<String, ArtemisAcpsDirectCommand> inProgressDirectActions = {};
  final Map<String, Completer<ArtemisAcpsAeaResponse>> _pendingDirectResponses = {};
  List<String> retriedTransactions = [];


  List<String> get bpCommandKeysDirect => inProgressDirectActions.entries
      .where((entry) => entry.value.bagTag==null)
      .map((entry) => entry.key)
      .toList();
  List<String> get bpCommandKeysAea => inProgressAeaActions.entries
      .where((entry) => entry.value.bagTag==null)
      .map((entry) => entry.key)
      .toList();

  List<String> get btCommandKeysDirect => inProgressDirectActions.entries
      .where((entry) => entry.value.boardingPass==null)
      .map((entry) => entry.key)
      .toList();

  List<String> get btCommandKeysAea => inProgressAeaActions.entries
      .where((entry) => entry.value.boardingPass==null)
      .map((entry) => entry.key)
      .toList();

  AcpsKioskUtil({required this.controller});

  void kioskRefresh(ArtemisAcpsKiosk? kiosk) {
    controller.updateKiosk(kiosk);
    controller.updateDevices(kiosk?.devices ?? []);
  }

  void kioskStatusRefresh(ArtemisAcpsKioskStatus kioskStatus) {
    controller.updateKioskStatus(kioskStatus);
  }

  void handleError(String error) {
    log("handleError ${error}");
    controller.onError?.call(error);
    // log("handle error ${error}");
  }

  Future<bool> initDevices() async {
    return true;
  }

  void updateReceivedData(ArtemisAcpsReceivedData receivedData) {
    controller.onReceivedData?.call(receivedData);
  }

  refreshSocketStatus(HubConnectionState? status) {
    HubConnectionState s = status ?? HubConnectionState.Disconnected;
    controller.updateSocketStatus(s);
    return;
  }

  Future<bool> connect(ArtemisAcpsKioskConfig config) async {
    bool response = true;
    _config = config;
    // print("Checkin ${_connectAddress } vs ${config.getStationQR}");
    if (_connectAddress == config.getStationQR) {
      response = true;
    }
    try {
      final defaultHeaders = MessageHeaders();
      defaultHeaders.setHeaderValue("DeviceID", config.deviceId);
      defaultHeaders.setHeaderValue("IsDcs", config.isDcs);
      defaultHeaders.setHeaderValue("AirportToken", config.airportToken);
      await disconnect();
      String url = '${config.baseUrl}?DeviceID=${config.deviceId}&IsDcs=${config.isDcs}&AirportToken=${config.airportToken}';
      log("URL $url");
      _hubConnection =
          HubConnectionBuilder()
              .withUrl(url, options: HttpConnectionOptions(skipNegotiation: true, transport: HttpTransportType.WebSockets, headers: defaultHeaders, accessTokenFactory: () async => jsonEncode(defaultHeaders.asMap)))
              .build();
      refreshSocketStatus(HubConnectionState.Connecting);
      await _hubConnection
          .start()!
          .catchError((e) {
            log("Error: $e");
            refreshSocketStatus(_hubConnection.state);
            _connectAddress = null;
            response = false;
          })
          .then((value) {
            log("Connection Started");
            refreshSocketStatus(_hubConnection.state);
            _connectAddress = config.getStationQR;

            log(_hubConnection.state.toString());
            _hubConnection.on("OnDevicesStatusChanged", onDevicesStatusChanged);
            _hubConnection.on("OnKioskStatusChanged", onArtemisAcpsKioskStatusChange);
            _hubConnection.on("OnReaderData", onReaderData);
            _hubConnection.on("AeaDirectResponse", aeaDirectResponse);
            _hubConnection.on("AeaResponse", aeaResponse);
            subscribe();

            response = true;
          })
          .onError((error, stackTrace) {
            _connectAddress = null;
            refreshSocketStatus(_hubConnection.state);
            response = false;
          });
    } catch (e) {
      log("Error: ${e.toString()}");
      removeAcps();
      response = false;
    }
    _hubConnection.onclose(({error}) {
      _connectAddress = null;
      response = false;
      refreshSocketStatus(_hubConnection.state);
    });
    _hubConnection.onreconnecting(_onReconnecting);
    _hubConnection.onreconnected(_onReconnected);

    return response;
  }

  Future<bool> subscribe() async {
    bool result1 = false;
    bool result2 = false;
    bool result3 = false;
    bool result4 = false;
    log("Subscribing");
    await _hubConnection.invoke('SubscribeToReceiveDeviceStatusByUserID', args: [devId!]).then((value) {
      log("Subscribed1");
      result1 = true;
    });
    await _hubConnection.invoke('SubscribeToReaderDataByUserID', args: [devId!]).then((value) {
      log("Subscribed2");
      result2 = true;
    });
    await _hubConnection.invoke('SubscribeToReceivePrintMessagesByUserID', args: [devId!]).then((value) {
      log("Subscribed3");
      result3 = true;
    });
    await _hubConnection.invoke('SubscribeToReceiveAeaDirectByUserID', args: [devId!]).then((value) {
      log("Subscribed4");
      result4 = true;
    });
    return result1 && result2 && result3 && result4;
  }

  Future<void> disconnect() async {
    try {
      await _hubConnection.stop();
      refreshSocketStatus(_hubConnection.state);
    } catch (e) {
      log(e.toString());
    }
  }

  void onDevicesStatusChanged(List<Object?>? arguments) {
    try {
      log("OnDeviceStatusChanged\n$arguments");
      if ((arguments ?? []).isNotEmpty) {
        ArtemisAcpsKiosk acps = ArtemisAcpsKiosk.fromJson(arguments!.first as Map<String, dynamic>);
        kioskRefresh(acps);
      }
    } catch (e) {
      log("$e");
    }
  }

  void onArtemisAcpsKioskStatusChange(List<Object?>? arguments) {
    try {
      log("OnArtemisAcpsKioskStatusChanged\n$arguments");
      if ((arguments ?? []).isNotEmpty) {
        ArtemisAcpsKioskStatus kioskStatus = ArtemisAcpsKioskStatus.fromJson(arguments!.first as Map<String, dynamic>);
        kioskStatusRefresh(kioskStatus);
        if (!kioskStatus.isOnline) {
          handleError(kioskStatus.message);
        }
      }
    } catch (e) {
      log("$e");
    }
  }

  void onReaderData(List<Object?>? arguments) {
    // [{data: WIFI:T:WPA;P:FARA@131313;S:FARANEGAR;H:FALSE;, deviceType: BC, deviceName: BC1, deviceID: 25C3C33E-1A05-42FC-8528-9409AFF23D59, readTime: 2024-08-15T14:31:07.0396548Z}]
    log("OnReaderData\n$arguments");
    try {
      if ((arguments ?? []).isNotEmpty) {
        ArtemisAcpsReceivedData receivedData = ArtemisAcpsReceivedData.fromJson(arguments!.first as Map<String, dynamic>);
        updateReceivedData(receivedData);
        controller.onReceivedData?.call(receivedData);
        if (receivedData.deviceType == "BG") {
          ArtemisAcpsAeaCommand req = ArtemisAcpsAeaCommand(
            deviceId: devId!,
            airlineCode: al,
            gateReader: GateReaderCommand(gateReaderId: null, data: [GateReaderAeaCommand(command: "CB#02", message: "Success", isSuccess: null)]),
          );
          invokeAeaCommand(req);
        }
        if (receivedData.deviceType == "BP") {
          ArtemisAcpsAeaCommand req = ArtemisAcpsAeaCommand(
            deviceId: devId!,
            airlineCode: al,
            boardingPass: BoardingPassCommand(
              printerId: null,
              data: [
                AeaCommand(
                  command:
                      "CP#1C01#01S#021#03NOAH ALVES#04CDG#05FRA#06LH#07723#08NOAH ALVES#09LH#10ECONOMY#1121JUN#1208:58#13CDG#14FRA#15Y#16ECONOMY#1721JUN#18QLCB3#21#2208:28#238F#248F#261#300#310#36@40#44A/8#50PASSENGER#51FROM#52TO#53SEAT#54GATE#55SEQ#56PCS#57WT#58NO SMOKING#59CLASS#60DATE#61TIME#62FLIGHT NO.#63TKNO.#65PNR#66BOARDING PASS#67NO SMOKING#68BTD#FAM1NOAH ALVES          QLCB3   CDGFRALH 723  172Y8F  1    100#FBM1NOAH ALVES          QLCB3   CDGFRALH 723  172Y8F  1    100#",
                ),
              ],
            ),
          );
          invokeAeaCommand(req);
        }
      }
    } catch (e) {
      log(e.toString());
      handleError(e.toString());
    }
  }

  Future<void> aeaDirectResponse(List<Object?>? arguments) async {
    log("aeaDirectResponse\n$arguments");
    try {
      if ((arguments ?? []).isNotEmpty) {
        ArtemisAcpsAeaResponse response = ArtemisAcpsAeaResponse.fromJson(arguments!.first as Map<String, dynamic>);
        if (response.isSuccessful) {
          completeTransaction(response);
          // inProgressAeaActions.removeWhere((a, b) => a == response.transactionId);
          // _pendingAeaResponses[response.transactionId]?.complete(response);
          // _pendingAeaResponses.remove(response.transactionId);
          //
          // inProgressDirectActions.removeWhere((a, b) => a == response.transactionId);
          // _pendingDirectResponses[response.transactionId]?.complete(response);
          // _pendingDirectResponses.remove(response.transactionId);
        }
        if (!response.isSuccessful && response.message != null) {
          if (!response.isSuccessful && response.message != "ERRTIMEOUT" && response.message?.toLowerCase() != "timeout") {
            // if ((response.message ?? '').startsWith("HDCERR6") || (response.message ?? '').startsWith("HDCERR3")) {
            //   if (retriedTransactions.contains(response.transactionId)) {
            //     handleError(response.message ?? 'Unknown Error');
            //     return;
            //   }
            //   retriedTransactions.add(response.transactionId);
            //   ArtemisAcpsAeaCommand? command = inProgressAeaActions[response.transactionId];
            //   if (command != null) {
            //     bool initRes = await initDevices();
            //     if (initRes) {
            //       invokeAeaCommand(command, overrideTransactionID: response.transactionId);
            //       completeTransaction(response);
            //       // inProgressAeaActions.remove(response.transactionId);
            //       // _pendingAeaResponses[response.transactionId]?.complete(response);
            //       // _pendingAeaResponses.remove(response.transactionId);
            //       //
            //       // inProgressDirectActions.removeWhere((a, b) => a == response.transactionId);
            //       // _pendingDirectResponses[response.transactionId]?.complete(response);
            //       // _pendingDirectResponses.remove(response.transactionId);
            //       return;
            //     }
            //   }
            // }
            handleError(response.message ?? 'Unknown Error');
            completeTransaction(response);
          }else{
            completeTransaction(response);

            handleError(response.message ?? 'Unknown Error');
          }
        }
      }
    } catch (e) {
      log((e as Error).stackTrace.toString());
    }
  }

  completeTransaction(ArtemisAcpsAeaResponse response){
    String transactionId= response.transactionId;

    inProgressAeaActions.remove(transactionId);
    _pendingAeaResponses[transactionId]?.complete(response);
    _pendingAeaResponses.remove(transactionId);

    inProgressDirectActions.removeWhere((a, b) => a == transactionId);
    _pendingDirectResponses[transactionId]?.complete(response);
    _pendingDirectResponses.remove(transactionId);
  }

  Future<ArtemisAcpsAeaResponse> invokeAeaCommand(ArtemisAcpsAeaCommand command, {String? overrideTransactionID}) async {
    command = command.copyWith(deviceId: devId!);
    String transactionID = overrideTransactionID ?? generateTransactionID();
    log("invoking\n${command.toJson()} TrID:$transactionID ${command.bagTag == null ? "BP" : "BT"}");
    inProgressAeaActions.putIfAbsent(transactionID, () => command);
    final completer = Completer<ArtemisAcpsAeaResponse>();
    _pendingAeaResponses[transactionID] = completer;
    log("Added _pendingAeaResponses ${transactionID}");
    _hubConnection.invoke("AeaCommandRequest", args: [devId!, transactionID, command]);
    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw TimeoutException("Operation timed out after 10 Seconds");
      },
    );
  }

  Future<ArtemisAcpsAeaResponse> invokeDirectCommand(ArtemisAcpsDirectCommand command, {String? overrideTransactionID}) async {
    command = command.copyWith(deviceId: devId!);
    String transactionID = overrideTransactionID ?? generateTransactionID();
    log("invoking\n DevID:$devId TrID:$transactionID ${command.boardingPass?.data.length} BPs ${command.bagTag?.data.length} BTs");
    inProgressDirectActions.putIfAbsent(transactionID, () => command);
    final completer = Completer<ArtemisAcpsAeaResponse>();
    _pendingDirectResponses[transactionID] = completer;

    _hubConnection.invoke("SendPrintAEA", args: [devId!,transactionID, command]);
    return completer.future.timeout(
      const Duration(seconds: 100),
      onTimeout: () {
        throw TimeoutException("Operation timed out after 10 Seconds");
      },
    );
  }

  void invokeAeaPRCommand(PrCommand command) {
    command = command.copyWith(deviceId: devId!);
    log("invoking\n${command.toJson()}");
    _hubConnection.invoke("PRPrintRequest", args: [devId!, command]);
  }

  void aeaResponse(List<Object?>? arguments) {
    log("aeaResponse\n$arguments");
  }

  String generateTransactionID() {
    return DateTime.now().toString();
  }

  removeAcps() {
    kioskRefresh(null);
  }

  Future<void> reconnect() async {
    if (_config == null) return;
    await disconnect();
    connect(_config!);
  }

  void _onReconnecting({Exception? error}) {
    log("_onReconnecting ${error.toString()}");
    if(error!=null){
      reconnect();
    }
  }

  void _onReconnected({String? connectionId}) {

    log("_onReconnected ${connectionId.toString()}");
  }
}
