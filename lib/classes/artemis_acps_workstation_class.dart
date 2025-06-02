
import 'package:artemis_acps/classes/artemis_acps_kiosk_config_class.dart';

class ArtemisAcpsWorkstation {
  final String deviceId;
  final String? kioskId;
  final String workstationName;
  final String computerName;
  final String airportToken;

  ArtemisAcpsWorkstation({
    required this.deviceId,
    required this.kioskId,
    required this.workstationName,
    required this.computerName,
    required this.airportToken,
  });

  ArtemisAcpsWorkstation copyWith({
    String? deviceId,
    String? kioskId,
    String? workstationName,
    String? computerName,
    String? airportToken,
  }) =>
      ArtemisAcpsWorkstation(
        deviceId: deviceId ?? this.deviceId,
        kioskId: kioskId ?? this.kioskId,
        workstationName: workstationName ?? this.workstationName,
        computerName: computerName ?? this.computerName,
        airportToken: airportToken ?? this.airportToken,
      );

  factory ArtemisAcpsWorkstation.fromJson(Map<String, dynamic> json) {

    return ArtemisAcpsWorkstation(
      deviceId: json["DeviceID"],
      kioskId: json["KioskID"],
      workstationName: json["WorkstationName"],
      computerName: json["ComputerName"],
      airportToken: json["AirportToken"]??'',
    );
  }

  Map<String, dynamic> toJson() => {
    "DeviceID": deviceId,
    "KioskID": kioskId,
    "WorkstationName": workstationName,
    "ComputerName": computerName,
    "AirportToken": airportToken,
  };

  ArtemisAcpsKioskConfig toConfig() => ArtemisAcpsKioskConfig(deviceId: deviceId, isDcs: '3', airportToken: airportToken, baseUrl: '', kioskId: kioskId);
}