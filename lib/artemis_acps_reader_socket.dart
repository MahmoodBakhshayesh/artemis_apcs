import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';

import 'artemis_acps_contoller.dart';
import 'classes/artemis_acps_aea_command_class.dart';
import 'classes/artemis_acps_broadcast_data_class.dart';
import 'classes/artemis_acps_device_config_class.dart';
import 'classes/artemis_acps_kiosk_class.dart';
import 'classes/artemis_kiosk_setting_row_class.dart';
import 'classes/artemis_kiosk_status_class.dart'; // ✅ ChangeNotifier

class AcpsAcpsReaderSocket extends ChangeNotifier {
  final ArtemisAcpsController controller;
  final ReaderDeviceType readerType;

  late HubConnection _hubConnection =
      HubConnectionBuilder()
          .withUrl('www.artemis.com', options: HttpConnectionOptions(skipNegotiation: true, transport: HttpTransportType.WebSockets, headers: MessageHeaders(), accessTokenFactory: () async => jsonEncode({})))
          .build();

  // ✅ per-instance status
  HubConnectionState _status = HubConnectionState.Disconnected;

  HubConnectionState get status => _status;

  // If you still want the controller to know about it too, keep this.
  // If you truly want to stop using controller.updateReaderSocketStatus,
  // set this to false.
  final bool syncStatusToController;

  String? get devId => _config?.deviceId;
  String al = "ZZ";

  String? get connectedAddress => _connectAddress;
  String? _connectAddress;
  ArtemisAcpsDeviceConfig? _config;

  Map<String, ArtemisAcpsBroadcastData> inProgressAeaActions = {};
  final Map<String, Completer<ArtemisAcpsAeaResponse>> _pendingAeaResponses = {};

  Map<String, ArtemisAcpsDirectCommand> inProgressDirectActions = {};
  final Map<String, Completer<ArtemisAcpsAeaResponse>> _pendingDirectResponses = {};
  List<String> retriedTransactions = [];
  List<ArtemisKioskSettingRow> kioskSetting = [];

  List<String> get bpCommandKeysDirect => inProgressDirectActions.entries.map((entry) => entry.key).toList();

  List<String> get bpCommandKeysAea => inProgressAeaActions.entries.map((entry) => entry.key).toList();

  AcpsAcpsReaderSocket({
    required this.controller,
    required this.readerType,
    this.syncStatusToController = false, // ✅ default: per-instance only
  });

  String _asset(String state, bool isBc) => "assets/images/devices/$state/${isBc ? 'BC' : 'OC'}.png";

  String get img {
    final isBc = readerType == ReaderDeviceType.bcDevice;

    return switch (status) {
      HubConnectionState.Connected => _asset("ready", isBc),
      HubConnectionState.Connecting || HubConnectionState.Reconnecting => _asset("init", isBc),
      _ => _asset("powerOff", isBc),
    };
  }

  void kioskRefresh(ArtemisAcpsKiosk? kiosk) {
    controller.updateKiosk(kiosk);
    controller.updateDevices(kiosk?.devices ?? []);
  }

  void kioskStatusRefresh(ArtemisAcpsKioskStatus kioskStatus) {
    controller.updateKioskStatus(kioskStatus);
  }

  void handleError(String error) {
    log("handleError $error");
    controller.onError?.call(error);
  }

  Future<bool> initDevices() async {
    return true;
  }

  void updateReceivedData(ArtemisAcpsReceivedData receivedData) {
    controller.onReceivedData?.call(receivedData);
  }

  // ✅ THIS is the key: instance-level, listenable status
  void refreshSocketStatus(HubConnectionState? status) {
    final s = status ?? HubConnectionState.Disconnected;

    if (_status != s) {
      _status = s;
      notifyListeners(); // 🔥 UI refresh for THIS instance
    }

    // Optional backward compatibility (keep old behavior if you want)
    if (syncStatusToController) {
      controller.updateReaderSocketStatus(s);
    }
  }

  Future<bool> connect(ArtemisAcpsDeviceConfig config) async {
    log("connect as reader");
    bool response = true;
    _config = config;

    if (_connectAddress == config.getUrl) {
      response = true;
    }

    try {
      final defaultHeaders = MessageHeaders();
      await disconnect();

      String url = config.getUrl;
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
            _connectAddress = config.getUrl;

            log(_hubConnection.state.toString());
            _hubConnection.on("VirtualDeviceRequest", onVirtualDeviceRequest);
            handShake();

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

  Future<void> handShake() async {
    _hubConnection.invoke("handshake", args: null).then((a) {});
    Future.delayed(Duration(seconds: _config!.timeout), () {
      handShake();
    });
  }

  Future<void> disconnect() async {
    try {
      await _hubConnection.stop();
      refreshSocketStatus(_hubConnection.state);
    } catch (e) {
      log(e.toString());
    }
  }

  void onVirtualDeviceRequest(List<Object?>? arguments) {
    try {
      if ((arguments ?? []).isNotEmpty) {
        log("$arguments");
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

  completeTransaction(ArtemisAcpsAeaResponse response) {
    String transactionId = response.transactionId;

    inProgressAeaActions.remove(transactionId);
    _pendingAeaResponses[transactionId]?.complete(response);
    _pendingAeaResponses.remove(transactionId);

    inProgressDirectActions.removeWhere((a, b) => a == transactionId);
    _pendingDirectResponses[transactionId]?.complete(response);
    _pendingDirectResponses.remove(transactionId);
  }

  // ✅ kept (you explicitly said you missed this)
  broadcastData(String data) async {
    log("broadcastData $data");
    try {
      if (_config == null) {
        log("config of reader is null");
        return;
      }
      ArtemisAcpsBroadcastData d = ArtemisAcpsBroadcastData(deviceId: _config!.devId, workstationToken: _config!.workstationToken, deviceType: _config!.deviceType!.typeName, message: data, messageType: "BARCODE");
      await invokeBroadcast(d);
    } catch (e) {
      log("E $e");
    }
  }

  Future<ArtemisAcpsAeaResponse> invokeBroadcast(ArtemisAcpsBroadcastData data, {String? overrideTransactionID}) async {
    String transactionID = overrideTransactionID ?? generateTransactionID();
    data = data.copyWith(deviceId: devId!, transactionId: transactionID, messageType: "BARCODE");

    log("invoking\n${data.toJson()} TrID:$transactionID ${data.message}");
    inProgressAeaActions.putIfAbsent(transactionID, () => data);
    final completer = Completer<ArtemisAcpsAeaResponse>();
    _pendingAeaResponses[transactionID] = completer;

    _hubConnection.invoke("VirtualDeviceResponse", args: [data]);

    return completer.future.timeout(
      const Duration(seconds: 10),
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
    if (error != null) {
      reconnect();
    }
  }

  void _onReconnected({String? connectionId}) {
    log("_onReconnected ${connectionId.toString()}");
  }

  void setKioskSetting(List<ArtemisKioskSettingRow> settings) {}

  // ✅ optional cleanup hook for UI owners
  @override
  void dispose() {
    // Best-effort stop; don't await inside dispose.
    try {
      _hubConnection.stop();
    } catch (_) {}
    super.dispose();
  }

  Widget getIcons({required double size}) {
    return Image.asset(img,width: size,height: size,package: 'artemis_acps');
  }
}
