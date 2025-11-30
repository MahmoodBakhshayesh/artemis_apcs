import 'dart:convert';
import 'dart:developer';

import 'package:app_device_net_info/app_device_net_info.dart';
import 'package:artemis_acps/artemis_acps_reader_socket.dart';
import 'package:artemis_acps/classes/artemis_acps_bagtag_class.dart';
import 'package:artemis_acps/classes/artemis_acps_boarding_pass_class.dart';
import 'package:artemis_acps/classes/artemis_acps_kiosk_class.dart';
import 'package:artemis_acps/classes/artemis_acps_kiosk_config_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_device_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_setting_row_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_status_class.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';

import 'artemis_acps_kiosk_socket.dart';
import 'classes/artemis_acps_aea_command_class.dart';
import 'classes/artemis_acps_device_config_class.dart';
import 'classes/artemis_acps_workstation_class.dart';
import 'widgets/configure_dialog.dart';
import 'widgets/workstation_select_dialog.dart';

class ArtemisAcpsController {
  late AcpsKioskUtil kioskUtil = AcpsKioskUtil(controller: this);
  late AcpsAcpsReaderSocket readerSocket = AcpsAcpsReaderSocket(controller: this);
  String baseUrl;
  String airport;
  String airline;
  bool locked;
  BoardingPassCommand? bpConfig;
  BagTagCommand? btConfig;
  void Function(String)? onError;
  void Function(ArtemisAcpsReceivedData receivedData)? onReceivedData;

  ArtemisAcpsController({required this.baseUrl, required this.airport, required this.airline, this.bpConfig, this.btConfig, required this.locked, this.onReceivedData, this.onError});

  void reconfigure({required String newAirline, required String newAirport, required String newBaseUrl, BoardingPassCommand? newBpConfig, BagTagCommand? newBtConfig}) {
    baseUrl = newBaseUrl;
    airport = newAirport;
    airline = newAirline;
    bpConfig = newBpConfig;
    btConfig = newBtConfig;
    station.value = newAirport;
  }

  final ValueNotifier<ArtemisAcpsWorkstation?> workstation = ValueNotifier<ArtemisAcpsWorkstation?>(null);
  final ValueNotifier<HubConnectionState> socketStatus = ValueNotifier<HubConnectionState>(HubConnectionState.Disconnected);
  final ValueNotifier<ArtemisAcpsKiosk?> kiosk = ValueNotifier<ArtemisAcpsKiosk?>(null);
  final ValueNotifier<ArtemisAcpsKioskStatus?> kioskStatus = ValueNotifier<ArtemisAcpsKioskStatus?>(null);
  final ValueNotifier<List<ArtemisKioskDevice>> devices = ValueNotifier<List<ArtemisKioskDevice>>([]);
  late ValueNotifier<String> station = ValueNotifier<String>(airport);
  late ValueNotifier<List<String>> printingBpsAea = ValueNotifier<List<String>>(kioskUtil.bpCommandKeysAea);
  late ValueNotifier<List<String>> printingBpsDirect = ValueNotifier<List<String>>(kioskUtil.bpCommandKeysDirect);
  late ValueNotifier<List<String>> printingBtsAea = ValueNotifier<List<String>>(kioskUtil.btCommandKeysAea);
  late ValueNotifier<List<String>> printingBtsDirect = ValueNotifier<List<String>>(kioskUtil.btCommandKeysDirect);
  late ValueNotifier<List<ArtemisKioskSettingRow>?> kioskSettings = ValueNotifier<List<ArtemisKioskSettingRow>?>(null);

  Map<String, dynamic>? get kioskSettingMap => kioskSettings.value == null ? null : Map.fromEntries(kioskSettings.value!.where((a) => a.isActive).map((x) => MapEntry(x.key, x.value)));

  Map<String, dynamic>? get kioskAllSettingMap => kioskSettings.value == null ? null : Map.fromEntries(kioskSettings.value!.map((x) => MapEntry(x.key, x.value)));

  void dispose() {
    socketStatus.dispose();
    kiosk.dispose();
    kioskStatus.dispose();
    devices.dispose();
  }

  void updateSocketStatus(HubConnectionState state) {
    socketStatus.value = state;
  }

  void setDataListener(void Function(ArtemisAcpsReceivedData receivedData)? listener) {
    onReceivedData = listener;
  }

  void updateKiosk(ArtemisAcpsKiosk? k) {
    kiosk.value = k;
  }

  void updateKioskStatus(ArtemisAcpsKioskStatus? s) {
    kioskStatus.value = s;
  }

  void updateDevices(List<ArtemisKioskDevice> dl) {
    devices.value = dl;
  }

  void updateWorkstation(ArtemisAcpsWorkstation? w) {
    workstation.value = w;
  }

  Future<List<ArtemisAcpsWorkstation>> getWorkstations() async {
    List<ArtemisAcpsWorkstation> results = [];
    // if(baseUrl == null || airport == null) return [];
    Dio dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {'content-type': 'application-json'}));
    String api = "$baseUrl/api/ACPS/RetrieveWorkstation?Airport=$airport";

    final res = await dio.get(api);
    if (res.statusCode == 200 && res.data != null) {
      if (res.data is String) {
        final json = jsonDecode(res.data);
        List<ArtemisAcpsWorkstation> ws = (json["ResultObject"] as List).map((a) => ArtemisAcpsWorkstation.fromJson(a)).toList();
        results = ws;
      } else if (res.data is Map<String, dynamic>) {
        List<ArtemisAcpsWorkstation> ws = (res.data["ResultObject"] as List).map((a) => ArtemisAcpsWorkstation.fromJson(a)).toList();
        results = ws;
      }
    }
    return results;
  }

  Future<void> connectWorkstation(ArtemisAcpsWorkstation workstation) async {
    updateWorkstation(workstation);
    final w = workstation.toConfig().copyWith(baseUrl: "$baseUrl/ACPSHub");
    final connection = await kioskUtil.connect(w);
    if (connection) {
      await getKioskSetting(w);
      // await kioskUtil.subscribe();
    }
  }

  Future<void> connectWorkstationWithQr(String qr) async {
    try {
      if (isGeneralPrinterQrKiosk(qr)) {
        var c = ArtemisAcpsKioskConfig.fromBarcode(qr);

        ArtemisAcpsWorkstation workstation = ArtemisAcpsWorkstation(
          deviceId: c.deviceId,
          workstationName: c.deviceName ?? 'QR-connected',
          computerName: c.deviceName ?? 'QR-connected',
          airportToken: c.airportToken,
          kioskId: c.kioskId,
        );
        updateWorkstation(workstation);
        // final w = workstation.toConfig();
        final connection = await kioskUtil.connect(c);
        if (connection) {
          await getKioskSetting(c);
        }
      }else{
        log("invalid barcode");
      }
    }catch(e){
      log("$e");
    }
  }

  getKioskSetting(ArtemisAcpsKioskConfig c) async {
    try {
      log("getKioskSetting");
      Dio dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {'content-type': 'application/json', 'api-key': workstation.value!.deviceId}));
      String api = "https://cupps.abomis.com/api/kiosk/ThirdPartyGetKioskParameters/${c.kioskId}";
      log("Setting from ${api}");
      final res = await dio.get(api);
      if (res.statusCode == 200) {
        log("we got settings");
        final List<ArtemisKioskSettingRow> settings = List<ArtemisKioskSettingRow>.from((res.data["result"] ?? []).map((x) => ArtemisKioskSettingRow.fromJson(x)));
        kioskSettings.value = settings;

        log("settings ${settings.length}");

      } else {
        log("failed");
      }
    } catch (e) {
      if (e is Error) {
        log(e.stackTrace.toString());
      }
    }
  }

  Future<ArtemisAcpsAeaResponse> printData({required List<ArtemisAcpsBoardingPass> bpList, required List<ArtemisAcpsBagtag> btList, ArtemisKioskDevice? bp, ArtemisKioskDevice? bt}) async {
    try {
      if (workstation.value == null) {
        throw Exception("No Workstation!");
      }
      final command = ArtemisAcpsDirectCommand(
        deviceId: workstation.value!.deviceId,
        airlineCode: airline,
        boardingPass: BoardingPassDirect(printerId: bp?.deviceName, data: bpList),
        bagTag: BagTagDirect(printerId: bt?.deviceName, data: btList),
      );
      final res = await kioskUtil.invokeDirectCommand(command);
      return res;
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<ArtemisAcpsAeaResponse> printAeaData({required List<String> bpCommandList, required List<String> btCommandList, ArtemisKioskDevice? bp, ArtemisKioskDevice? bt}) async {
    try {
      if (workstation.value == null) {
        throw Exception("No Workstation!");
      }
      final command = ArtemisAcpsAeaCommand(
        deviceId: workstation.value!.deviceId,
        airlineCode: airline,
        boardingPass: BoardingPassCommand(printerId: bp?.deviceName, data: bpCommandList.map((a) => AeaCommand(command: a)).toList()),
        bagTag: BagTagCommand(printerId: bt?.deviceName, data: btCommandList.map((a) => AeaCommand(command: a)).toList()),
      );
      final res = await kioskUtil.invokeAeaCommand(command);
      log("res deep ${res.message}");
      return res;
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<ArtemisAcpsAeaResponse> testAeaPrint({bool hasBp = true, bool hasBt = true}) async {
    // log("testAeaPrint1");
    String bp1 =
        '''PT##\$G6A#@;#TICK#CHEC#BOAR#0101110112011301210122012301C#0201A34#1919C54#2020C01#2104M04M68#2605C24D54#2903E54F#3030D01L#3207G02G60#3311H60K04#3408K22#3608G40#3903F54F#4030D24L#4110I60#4304G11#4404M57#4504G32#4710G19#50B6R011651#51B6R541651#6015I01L#6508C34#7021M14#7403D45D67F#7503D48D70F#8012J60K37#8212K60L37#8412L60M37#''';
    String bp2 =
        "CP#A#01G#CP#C01#02@@12#19PRINT/TEST/MR#20PRINT/TEST/MR#210001#29AAA#30A TEST#326E9999#3319 OCT 2024#340900 HRS#360830 HRS#39BBB#40B TEST#4198765432#4313#441A#451A#47ZONE -#50M1TEST PRINT          98765432AAABBB6E 9999 293Y1A  1    100#51M1TEST PRINT          98765432AAABBB6E 9999 293Y1A  1    100#70E-TKT:              #80#82";
    String bp3 =
        "TT12#21T001157600ALL@00000Seq:#32T004028300ALL@00000Flight#33T001149300ALL@00000Date:#34T100528300ALL@00000Boarding Time#40T051219900AAA@00000To#42T027228300ALL@00000Gate #43T080528300ALL@00000Seat#46T168024300ALL@00000To#4BT078249300ALL@00000Services:#4CT039249300ALL@00000Departure:#53T135832800ALL@00000Flight:#54T135836800ALL@00000Date:#57T164157700ALL@00000Seq:#5AT135857700ALL@00000Seat:#5BB0017366125022000200000#5CB0252366125018800200000#5DB0455366125031000200000#5EB0781366125018700200000#5FB0985366125027000200000#60T135840800ALL@00000PNR:#61T135844800ALL@00000Services:#62T047328300ALL@00000Boarding#63T066074000ALL@00000Gate is subject to change and will close#64T071678400ALL@00000minutes prior to departure#65T065778200AAA@0000025#";

    String bt1 =
        "BTT0101*F 500185=#03C0M1145040402#04C0 1004200201#05B1 A007250631=04#06B1 A385250631=04#08C0 1015200201=04#09B1 A018250631=04#10C0 5395300201=04#11C0 5395100201=29#14C0M2169270402#15C0 1004040201#16C0 1015040201=15#17C0 5395460201=15#20B1M3039444041=04#21B1MA080244041=04#22C0M1135230303#23C0MA133130705#25C0M1147230303#26C0MA145130705#28C0MA169260504#29C0MB176260806#30C0MA187250806#31C0 A198260201#35C0 1004400201=29#41C0M1145120402=04#42C0M1150040402#43C0M1156040402#44C0M1162040402#45C0 5356440502#52C0 5361440502=43#53C0 5366440502=42#55C0 5371440502=29#62C0 5376440502=03#63C0 5376360502=04#64C0 5382440502=15#9AS0M1133010548#9BS0M1144010548#9CS0M1168010548#9DC0M3205450402#9FC0 1015400201=29#A1C0MA033240303=04#A2C0M4174470402=15#A3S0M1122010548#A4C0 E350250202INDIGO#";
    String bt2 = "BTP010101#036E#040312972277#15SEQ-0001#22#23#25#26#286E9999#29BBB#4219OCT24#4398765432#44PRINT/TEST#45PRINT/TEST#";
    final res = await printAeaData(bpCommandList: hasBp ? [bp1, bp2, bp3] : [], btCommandList: hasBt ? [bt1, bt2] : []);
    // log("testAeaPrint2");
    // log("res ${res.description}");
    return res;
  }

  Future<bool> printApi({required List<ArtemisAcpsBoardingPass> bpList, required List<ArtemisAcpsBagtag> btList, ArtemisKioskDevice? bp, ArtemisKioskDevice? bt}) async {
    try {
      if (workstation.value == null) {
        throw Exception("No Workstation!");
      }
      final command = ArtemisAcpsDirectCommand(
        deviceId: workstation.value!.deviceId,
        airlineCode: airline,
        boardingPass: BoardingPassDirect(printerId: bp?.deviceName, data: bpList),
        bagTag: BagTagDirect(printerId: bt?.deviceName, data: btList),
      );
      Dio dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {'content-type': 'application/json', 'api-key': workstation.value!.deviceId}));
      String api = "$baseUrl/api/ACPSPrint/PrintTravelDocument";
      log(api);
      log(workstation.value!.deviceId);
      // log(jsonEncode(command.toJson()));
      final res = await dio.post(api, data: command.toJson());
      log(res.data.toString());
      return res.statusCode == 200;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> printApiJson({required List<Map<String, dynamic>> bpJsonList, required List<Map<String, dynamic>> btJsonList, ArtemisKioskDevice? bp, ArtemisKioskDevice? bt}) async {
    try {
      if (workstation.value == null) {
        throw Exception("No Workstation!");
      }
      final commandJson = {"DeviceID": workstation.value!.deviceId, "AirlineCode": airline, "BoardingPass": bpJsonList, "BagTag": btJsonList};
      Dio dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {'content-type': 'application/json', 'api-key': workstation.value!.deviceId}));
      String api = "$baseUrl/api/ACPSPrint/PrintTravelDocument";
      log(api);
      log(workstation.value!.deviceId);
      // log(jsonEncode(command.toJson()));
      final res = await dio.post(api, data: commandJson);
      return res.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> disconnectSocket() async {
    await kioskUtil.disconnect();

  }

  Future<void> reconnectSocket() async {
    await kioskUtil.reconnect();
  }

  bool isGeneralPrinterQrKiosk(String barcode) => barcode.toLowerCase().startsWith("bdcsprinterqr|kiosk|") && barcode.split("|").length >= 6;

  Future<void> selectWorkstation(BuildContext context) async {
    final ws = await getWorkstations();
    final selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WorkstationSelectDialog(workstations: ws);
      },
    );
    if (selected is ArtemisAcpsWorkstation) {
      connectWorkstation(selected);
    }
  }

  Future<void> configureAcps(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfigureDialog(controller: this);
      },
    );
  }

  void disconnect() {
    disconnectSocket();
    updateWorkstation(null);
    updateKiosk(null);
    kioskSettings.value = null;
  }

  Future<void> connectAsScanner() async {
    log("connect as scanner");
    if(kiosk.value == null || !(kioskAllSettingMap??{}).containsKey("hardwareID")){
      log("${kiosk.value == null} -- ${!(kioskAllSettingMap??{}).containsKey("hardwareID")}");
      return;
    }
 try {
   final info = await AppDeviceNetworkInfo.getAll();
   ArtemisAcpsDeviceConfig config = ArtemisAcpsDeviceConfig(timeout: 10, deviceId: info.device.id, deviceType: "bc", workstationToken: (kioskAllSettingMap??{})["hardwareID"], version: info.app.versionKey??'', os: info.device.os.name);

   final connection = await readerSocket.connect(config);
      log("connection ${connection}");
    }catch(e){
      log("${e}");
      if (e is Error){
        log("${e.stackTrace}");
      }
    }
  }

  Future<void> broadcastData(String data)async{
    readerSocket.broadcastData(data);
  }
}
