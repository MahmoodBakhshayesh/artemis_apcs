import 'dart:developer';

import 'package:artemis_acps/classes/artemis_kiosk_status_class.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';

import 'classes/artemis_acps_kiosk_class.dart';
import 'classes/artemis_kiosk_device_class.dart';

class SocketStatusManager extends ChangeNotifier {
  bool _connected = false;

  bool get connected => _connected;

  void update(HubConnectionState status) {
    _connected = status == HubConnectionState.Connected;
    notifyListeners();
  }
}

class KioskStatusManager extends ChangeNotifier {
  ArtemisAcpsKiosk? _kiosk;

  ArtemisAcpsKiosk? get kiosk => _kiosk;

  void update(ArtemisAcpsKiosk? newKiosk) {
    _kiosk = newKiosk;
    notifyListeners();
  }
}

class KioskStatusStatusManager extends ChangeNotifier {
  ArtemisAcpsKioskStatus? _kioskStatus;

  ArtemisAcpsKioskStatus? get kiosk => _kioskStatus;

  void update(ArtemisAcpsKioskStatus? newKiosk) {
    log("setting KioskStatusStatusManager isOnline${newKiosk?.isOnline}");
    _kioskStatus = newKiosk;
    notifyListeners();
  }
}

class DeviceStatusManager extends ChangeNotifier {
  final List<ArtemisKioskDevice> _devices = [];

  List<ArtemisKioskDevice> get devices => List.unmodifiable(_devices);

  void updateDevices(List<ArtemisKioskDevice> newDevices) {
    _devices
      ..clear()
      ..addAll(newDevices);
    notifyListeners();
  }
}

class StatusManagerNotifier extends ChangeNotifier {
  StatusManager _statusManager = StatusManager();

  StatusManager get statusManager => _statusManager;

  void update() {
    _statusManager = StatusManager();
    notifyListeners();
  }
}

class StatusManager {
  final socketStatus = SocketStatusManager();
  final kioskStatus = KioskStatusManager();
  final deviceStatus = DeviceStatusManager();
  final kioskStatusStatus = KioskStatusStatusManager();
}


class StatusProvider extends InheritedWidget {
  final StatusManager manager;

  const StatusProvider({
    super.key,
    required this.manager,
    required super.child,
  });

  static StatusManager of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<StatusProvider>();
    assert(result != null, 'No StatusProvider found in context');
    return result!.manager;
  }

  @override
  // bool updateShouldNotify(StatusProvider oldWidget) => manager != oldWidget.manager;
  bool updateShouldNotify(StatusProvider oldWidget) => true;
}