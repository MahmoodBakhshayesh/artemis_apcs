import 'package:artemis_acps/extensions/list_ext.dart';

class ArtemisAcpsDeviceConfig {
  final String deviceId;
  final ReaderDeviceType? deviceType;
  final String workstationToken;
  final int timeout;
  final String version;
  final String os;

  ArtemisAcpsDeviceConfig({
    required this.deviceId,
    required this.deviceType,
    required this.workstationToken,
    this.timeout =10,
    required this.version,
    required this.os,
  });

  ArtemisAcpsDeviceConfig copyWith({
    String? deviceId,
    ReaderDeviceType? deviceType,
    String? workstationToken,
    int? timeout,
    String? version,
    String? os,
  }) =>
      ArtemisAcpsDeviceConfig(
        deviceId: deviceId ?? this.deviceId,
        deviceType: deviceType ?? this.deviceType,
        workstationToken: workstationToken ?? this.workstationToken,
        timeout: timeout ?? this.timeout,
        version: version ?? this.version,
        os: os ?? this.os,
      );

  factory ArtemisAcpsDeviceConfig.fromJson(Map<String, dynamic> json) => ArtemisAcpsDeviceConfig(
    deviceId: json["DeviceID"],
    deviceType: ReaderDeviceType.values.firstWhereOrNull((a)=>a.typeName == json["DeviceType"]),
    workstationToken: json["WorkstationToken"],
    timeout: json["Timeout"],
    version: json["Version"],
    os: json["OS"],
  );

  String get devId => "${deviceId}-${deviceType?.typeName}";
  String get getUrl => "https://cupps.abomis.com/hubs/platformHub?type=${deviceType?.typeName}&device_id=${devId}&token=${workstationToken}&handshake_timeout=${timeout}&version=${version}&os=${os}";


  Map<String, dynamic> toJson() => {
    "DeviceID": devId,
    "DeviceType": deviceType?.typeName,
    "WorkstationToken": workstationToken,
    "Timeout": timeout,
    "Version": version,
    "OS": os,
  };


}

enum ReaderDeviceType {
  bcDevice,
  ocDevice
}

extension ReaderDeviceTypeDetails on ReaderDeviceType {
  String get typeName {
    switch(this){
      case ReaderDeviceType.bcDevice:
        return "bc_device";
      case ReaderDeviceType.ocDevice:
        return "oc_device";
    }
  }
}