import 'package:artemis_acps/classes/artemis_acps_kiosk_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_status_class.dart';
import 'package:signalr_netcore/hub_connection.dart';

import 'artemis_kiosk_device_class.dart';

class ArtemisAcpsStatus {
  HubConnectionState socketStatus = HubConnectionState.Disconnected;
  ArtemisAcpsKiosk? kiosk;
  ArtemisAcpsKioskStatus? kioskStatus;
  List<ArtemisKioskDevice> devices = [];

  ArtemisAcpsStatus();

  bool get socketConnected => socketStatus == HubConnectionState.Connected;


}