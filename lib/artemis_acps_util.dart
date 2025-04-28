import 'dart:convert';

import 'package:artemis_acps/artemis_acps_kiosk_socket.dart';
import 'package:artemis_acps/classes/artemis_acps_kiosk_class.dart';
import 'package:artemis_acps/classes/artemis_acps_kiosk_config_class.dart';
import 'package:artemis_acps/classes/artemis_acps_workstation_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_device_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_status_class.dart';
import 'package:artemis_acps/notifier.dart';
import 'package:artemis_acps/providers/artemis_acps_status_provider.dart';
import 'package:artemis_acps/status_managers.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:dio/dio.dart';
import 'package:signalr_netcore/iconnection.dart';
import 'classes/artemis_acps_aea_command_class.dart';

typedef KioskStatusRefresh = void Function(ArtemisAcpsKioskStatus newStatus);
typedef KioskRefresh = void Function(ArtemisAcpsKiosk? newStatus);
typedef ArtemisAcpsErrorHandler = void Function(String error);
typedef ReceivedDataHandler = void Function(ArtemisAcpsReceivedData data);
typedef SocketStatusRefresh = void Function(HubConnectionState status);

class ArtemisAcpsUtil {
  static StatusManager statusManager = StatusManager();
  static KioskStatusRefresh? _kioskStatusRefresh;
  static KioskRefresh? _kioskRefresh;
  static ArtemisAcpsErrorHandler? _onError;
  static ReceivedDataHandler? _onReceiveData;
  static SocketStatusRefresh? _onSocketStatusRefresh;
  static BoardingPassCommand? _bpConfig;
  static BagTagCommand? _btConfig;
  static String? _al;
  static String? _baseUrl;
  static String? _airport;
  static ArtemisAcpsWorkstation? _workstation;


  static void init({
    required KioskStatusRefresh onKioskStatusChanged,
    required KioskRefresh onKioskChanged,
    required ArtemisAcpsErrorHandler onError,
    required ReceivedDataHandler onReceiveData,
    required SocketStatusRefresh onSocketStatusRefresh,
    required String baseUrl,
    required String airport,
  }) {
    _kioskStatusRefresh = onKioskStatusChanged;
    _kioskRefresh = onKioskChanged;
    _onError = onError;
    _onReceiveData = onReceiveData;
    _onSocketStatusRefresh = onSocketStatusRefresh;
    _baseUrl = baseUrl;
    _airport = airport;
  }

  static void configure({required BoardingPassCommand? boConfig, required BagTagCommand? btConfig, required String? al}) {
    _bpConfig = boConfig;
    _btConfig = btConfig;
    _btConfig = btConfig;
    _al = al;
  }

  static void notifyKioskStatusChange(ArtemisAcpsKioskStatus status) {
    ArtemisAcpsStatusProvider.updateKioskStatusStatus(status);
    _kioskStatusRefresh?.call(status);
  }

  static void notifyKioskChange(ArtemisAcpsKiosk? kiosk) {
    ArtemisAcpsStatusProvider.updateKioskStatus(kiosk);
    ArtemisAcpsStatusProvider.updateDeviceStatus(kiosk?.devices??[]);
    _kioskRefresh?.call(kiosk);
  }

  static void notifySocketStatus(HubConnectionState status) {
    ArtemisAcpsStatusProvider.updateSocketStatus(status);
    _onSocketStatusRefresh?.call(status);
  }

  static void handleError(String error) {
    _onError?.call(error);
  }

  static void onReceiveData(ArtemisAcpsReceivedData data) {
    _onReceiveData?.call(data);
  }

  static void initializeDevices() {
    if(_workstation == null) return ;
    // AcpsKioskUtil.invokeAeaCommand(ArtemisAcpsAeaCommand(deviceId:_workstation!.deviceId, airlineCode: _al, boardingPass: _bpConfig, bagTag: _btConfig));
  }

  static Future<List<ArtemisAcpsWorkstation>> getWorkstations() async{
    List<ArtemisAcpsWorkstation> results = [];
    if(_baseUrl == null || _airport == null) return [];
    Dio dio = Dio(BaseOptions(baseUrl: _baseUrl!,headers: {'content-type':'application-json'}));
    String api = "$_baseUrl/api/ACPS/RetrieveWorkstation?Airport=$_airport";

    final res = await dio.get(api);
    if(res.statusCode == 200 && res.data != null ){
      if(res.data is String){
        final json = jsonDecode(res.data);
        List<ArtemisAcpsWorkstation> ws = (json["ResultObject"] as List).map((a)=>ArtemisAcpsWorkstation.fromJson(a)).toList();
        results = ws;
      }else if(res.data is Map<String,dynamic>){
        List<ArtemisAcpsWorkstation> ws = (res.data["ResultObject"] as List).map((a)=>ArtemisAcpsWorkstation.fromJson(a)).toList();
        results = ws;
      }
    }
    return results;
  }

  static Future<void> connectWorkstation(ArtemisAcpsWorkstation workstation) async {
    // statusManager.socketStatus.update(HubConnectionState.Connected);
    // ArtemisAcpsStatusProvider.updateSocketStatus(HubConnectionState.Connected);
    // _workstation = workstation;
    // final connection = await AcpsKioskUtil.connect(workstation.toConfig().copyWith(baseUrl: "$_baseUrl/ACPSHub"));
    // if(connection){
    //   await AcpsKioskUtil.subscribe();
    // }
  }



}
