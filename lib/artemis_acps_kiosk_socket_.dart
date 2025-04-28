import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:artemis_acps/artemis_acps.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';

import 'artemis_acps_util.dart';
import 'classes/artemis_acps_aea_command_class.dart';
import 'classes/artemis_acps_kiosk_class.dart';
import 'classes/artemis_acps_kiosk_config_class.dart';
import 'classes/artemis_kiosk_status_class.dart';

class AcpsKioskUtil {
  AcpsKioskUtil._();

  static final AcpsKioskUtil _instance = AcpsKioskUtil._();

  factory AcpsKioskUtil() => _instance ?? AcpsKioskUtil._();
  static HubConnection _hubConnection = HubConnectionBuilder().build();

  String? get devId => _config?.deviceId;
  static String al = "ZZ";
  static String? get connectedAddress => _instance._connectAddress;
  String? _connectAddress;
  ArtemisAcpsKioskConfig? _config;

  static Map<String, ArtemisAcpsAeaCommand> inProgressActions = {};
  static Map<String, Completer<ArtemisAcpsAeaResponse>> _pendingResponses = {};
  static List<String> retriedTransactions = [];

  static void kioskRefresh(ArtemisAcpsKiosk? kiosk) {
    ArtemisAcpsUtil.notifyKioskChange(kiosk);
  }

  static void kioskStatusRefresh(ArtemisAcpsKioskStatus kioskStatus) {
    ArtemisAcpsUtil.notifyKioskStatusChange(kioskStatus);
  }

  static void handleError(String error) {
    ArtemisAcpsUtil.handleError(error);
  }

  static Future<bool> initDevices() async {
    ArtemisAcpsUtil.initializeDevices();
    return true;
    // await PrinterUtil.initializeDevices(ref.read(flightDetailsProvider)!.hardwareSettings!);
    // ref.read(acpsStatusProvide.notifier).update((s) => acps);
  }

  static void updateReceivedData(ArtemisAcpsReceivedData receivedData){
    ArtemisAcpsUtil.onReceiveData(receivedData);
  }


  static refreshSocketStatus(HubConnectionState? status) {
    HubConnectionState s = status ?? HubConnectionState.Disconnected;
    ArtemisAcpsUtil.notifySocketStatus(s);
    return;
    if (s == HubConnectionState.Disconnected) {
      removeAcps();
    }
  }

  static Future<bool> connect(ArtemisAcpsKioskConfig config) async {
    bool response = true;
    _instance._config = config;
    // print("Checkin ${_instance._connectAddress } vs ${config.getStationQR}");
    if (_instance._connectAddress == config.getStationQR) {
      response = true;
    }
    try {
      final defaultHeaders = MessageHeaders();
      defaultHeaders.setHeaderValue("DeviceID", config.deviceId);
      defaultHeaders.setHeaderValue("IsDcs", config.isDcs);
      defaultHeaders.setHeaderValue("AirportToken", config.airportToken);
      await disconnect();
      String url = '${config.baseUrl}?DeviceID=${config.deviceId}&IsDcs=${config.isDcs}&AirportToken=${config.airportToken}';
      print("URL $url");
      _hubConnection =
          HubConnectionBuilder()
              .withUrl(url, options: HttpConnectionOptions(skipNegotiation: true, transport: HttpTransportType.WebSockets, headers: defaultHeaders, accessTokenFactory: () async => jsonEncode(defaultHeaders.asMap)))
              .build();
      await _hubConnection
          .start()!
          .catchError((e) {
            log("Error: $e");
            refreshSocketStatus(_hubConnection.state);
            _instance._connectAddress = null;
            response = false;
          })
          .then((value) {
            log("Connection Started");
            refreshSocketStatus(_hubConnection.state);
            _instance._connectAddress = config.getStationQR;

            log(_hubConnection.state.toString());
            _hubConnection.on("OnDevicesStatusChanged", onDevicesStatusChanged);
            _hubConnection.on("OnKioskStatusChanged", onArtemisAcpsKioskStatusChange);
            _hubConnection.on("OnReaderData", onReaderData);
            _hubConnection.on("AeaDirectResponse", aeaDirectResponse);
            _hubConnection.on("AeaResponse", aeaResponse);
            response = true;
          })
          .onError((error, stackTrace) {
            _instance._connectAddress = null;
            refreshSocketStatus(_hubConnection.state);
            response = false;
          });
    } catch (e) {
      log("Error: ${e.toString()}");
      removeAcps();
      response = false;
    }
    _hubConnection.onclose(({error}) {
      _instance._connectAddress = null;
      response = false;
      refreshSocketStatus(_hubConnection.state);
    });

    return response;
  }

  static Future<bool> subscribe() async {
    bool result1 = false;
    bool result2 = false;
    bool result3 = false;
    bool result4 = false;
    log("Subscribing");
    await _hubConnection.invoke('SubscribeToReceiveDeviceStatusByUserID', args: [_instance.devId!]).then((value) {
      log("Subscribed1");
      result1 = true;
    });
    await _hubConnection.invoke('SubscribeToReaderDataByUserID', args: [_instance.devId!]).then((value) {
      log("Subscribed2");
      result2 = true;
    });
    await _hubConnection.invoke('SubscribeToReceivePrintMessagesByUserID', args: [_instance.devId!]).then((value) {
      log("Subscribed3");
      result3 = true;
    });
    await _hubConnection.invoke('SubscribeToReceiveAeaDirectByUserID', args: [_instance.devId!]).then((value) {
      log("Subscribed4");
      result4 = true;
    });
    return result1 && result2 && result3 && result4;
  }

  static Future<void> disconnect() async {
    try {
      await _hubConnection.stop();
      refreshSocketStatus(_hubConnection.state);
    } catch (e) {
      print(e);
    }
  }

  static void onDevicesStatusChanged(List<Object?>? arguments) {
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

  static void onArtemisAcpsKioskStatusChange(List<Object?>? arguments) {
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

  static void onReaderData(List<Object?>? arguments) {
    // [{data: WIFI:T:WPA;P:FARA@131313;S:FARANEGAR;H:FALSE;, deviceType: BC, deviceName: BC1, deviceID: 25C3C33E-1A05-42FC-8528-9409AFF23D59, readTime: 2024-08-15T14:31:07.0396548Z}]
    log("OnReaderData\n$arguments");
    try {
      if ((arguments ?? []).isNotEmpty) {
        ArtemisAcpsReceivedData receivedData = ArtemisAcpsReceivedData.fromJson(arguments!.first as Map<String, dynamic>);
        updateReceivedData(receivedData);
        if (receivedData.deviceType == "BG") {
          ArtemisAcpsAeaCommand req = ArtemisAcpsAeaCommand(
            deviceId: _instance.devId!,
            airlineCode: al,
            gateReader: GateReaderCommand(gateReaderId: null, data: [GateReaderAeaCommand(command: "CB#02", message: "Success", isSuccess: null)]),
          );
          invokeAeaCommand(req);
        }
        if (receivedData.deviceType == "BP") {
          ArtemisAcpsAeaCommand req = ArtemisAcpsAeaCommand(
            deviceId: _instance.devId!,
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
      print(e);
    }
  }

  static Future<void> aeaDirectResponse(List<Object?>? arguments) async {
    print("aeaDirectResponse\n$arguments");
    try {
      if ((arguments ?? []).isNotEmpty) {
        print(arguments!.first.runtimeType);
        ArtemisAcpsAeaResponse response = ArtemisAcpsAeaResponse.fromJson(arguments.first as Map<String, dynamic>);
        if (response.isSuccessful) {
          inProgressActions.removeWhere((a, b) => a == response.transactionId);
          _pendingResponses[response.transactionId]?.complete(response);
          _pendingResponses.remove(response.transactionId);
        }
        if (!response.isSuccessful && response.message != null) {
          if (!response.isSuccessful && response.message != "ERRTIMEOUT" && response.message?.toLowerCase() != "timeout") {
            if ((response.message ?? '').startsWith("HDCERR6") || (response.message ?? '').startsWith("HDCERR3")) {
              if (retriedTransactions.contains(response.transactionId)) {
                handleError(response.message ?? 'Unknown Error');
                return;
              }
              retriedTransactions.add(response.transactionId);
              ArtemisAcpsAeaCommand? command = inProgressActions[response.transactionId];
              if (command != null) {
                bool initRes = await initDevices();
                if (initRes) {
                  invokeAeaCommand(command, overrideTransactionID: response.transactionId);
                  inProgressActions.remove(response.transactionId);
                  _pendingResponses[response.transactionId]?.complete(response);
                  _pendingResponses.remove(response.transactionId);
                  return;
                }
              }
            }
            handleError(response.message ?? 'Unknown Error');
          }
        }
      }
    } catch (e) {
      print((e as Error).stackTrace);
    }
  }

  static Future<ArtemisAcpsAeaResponse> invokeAeaCommand(ArtemisAcpsAeaCommand command, {String? overrideTransactionID}) async {
    command = command.copyWith(deviceId: _instance.devId!);
    String transactionID = overrideTransactionID ?? generateTransactionID();
    print("invoking\n${command.toJson()} TrID:$transactionID ${command.bagTag == null ? "BP" : "BT"}");
    inProgressActions.putIfAbsent(transactionID, () => command);
    final completer = Completer<ArtemisAcpsAeaResponse>();
    _pendingResponses[transactionID] = completer;

    _hubConnection.invoke("AeaCommandRequest", args: [_instance.devId!, transactionID, command]);
    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw TimeoutException("Operation timed out after 10 Seconds");
      },
    );
  }

  static void invokeAeaPRCommand(PrCommand command) {
    command = command.copyWith(deviceId: _instance.devId!);
    log("invoking\n${command.toJson()}");
    _hubConnection.invoke("PRPrintRequest", args: [_instance.devId!, command]);
  }

  static void aeaResponse(List<Object?>? arguments) {
    print("aeaResponse\n$arguments");
  }

  static String generateTransactionID() {
    return DateTime.now().toString();
  }


  static removeAcps() {
    kioskRefresh(null);
  }

  static Future<void> reconnect() async {
    if (_instance._config == null) return;
    await disconnect();
    connect(_instance._config!);
  }
}
