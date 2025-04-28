import 'package:artemis_acps/classes/artemis_acps_kiosk_class.dart';
import 'package:riverpod/riverpod.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'classes/artemis_acps_aea_command_class.dart';
import 'classes/artemis_kiosk_status_class.dart';

final kioskStatusProvider = StateProvider<ArtemisAcpsKioskStatus?>((ref) => null);
final devicesHubStatusProvider = StateProvider<HubConnectionState>((ref) => HubConnectionState.Disconnected);
final acpsStatusProvide = StateProvider<ArtemisAcpsKiosk?>((ref) => null);
final acpsReceivedDataProvider = StateProvider<List<ArtemisAcpsReceivedData>>((ref) => []);

