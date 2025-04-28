import 'package:artemis_acps/classes/artemis_acps_kiosk_class.dart';
import 'package:artemis_acps/classes/artemis_acps_status_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_device_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_status_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalr_netcore/hub_connection.dart';

class ArtemisAcpsStatusNotifier extends ChangeNotifier {
  ArtemisAcpsStatus status = ArtemisAcpsStatus();


  ArtemisAcpsStatusNotifier._(this.status);

  static final ArtemisAcpsStatusNotifier instance = ArtemisAcpsStatusNotifier._(ArtemisAcpsStatus());

  void updateSocketStatus(HubConnectionState state){
    status.socketStatus = state;
    notifyListeners();
  }
  void updateKioskStatus(ArtemisAcpsKiosk? kiosk){
    status.kiosk = kiosk;
    notifyListeners();
  }
  void updateKioskStatusStatus(ArtemisAcpsKioskStatus state){
    status.kioskStatus = state;
    notifyListeners();
  }
  void updateDeviceStatus(List<ArtemisKioskDevice> devices){
    status.devices = devices;
    notifyListeners();
  }
}

class ArtemisAcpsStatusProvider extends InheritedNotifier<ArtemisAcpsStatusNotifier>{
  const ArtemisAcpsStatusProvider._({super.key, super.notifier, required super.child});

  factory ArtemisAcpsStatusProvider({Key? key,required Widget child}){
    return ArtemisAcpsStatusProvider._(key: key,notifier: ArtemisAcpsStatusNotifier.instance,child: child,);
  }

  static ArtemisAcpsStatus of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ArtemisAcpsStatusProvider>()!.notifier!.status;
  static bool socketOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ArtemisAcpsStatusProvider>()!.notifier!.status.socketConnected;

  @override
  bool updateShouldNotify(covariant InheritedNotifier<ArtemisAcpsStatusNotifier> oldWidget) {
    return true;
  }

  static void updateSocketStatus(HubConnectionState state){
    ArtemisAcpsStatusNotifier.instance.updateSocketStatus(state);
  }
  static void updateKioskStatus(ArtemisAcpsKiosk? kiosk){
    ArtemisAcpsStatusNotifier.instance.updateKioskStatus(kiosk);

  }
  static void updateKioskStatusStatus(ArtemisAcpsKioskStatus state){
    ArtemisAcpsStatusNotifier.instance.updateKioskStatusStatus(state);

  }
  static void updateDeviceStatus(List<ArtemisKioskDevice> devices){
    ArtemisAcpsStatusNotifier.instance.updateDeviceStatus(devices);
  }

}