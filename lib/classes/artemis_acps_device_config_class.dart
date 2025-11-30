class ArtemisAcpsDeviceConfig {
  final String deviceId;
  final String? deviceType;
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
    String? deviceType,
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
    deviceType: json["DeviceType"],
    workstationToken: json["WorkstationToken"],
    timeout: json["Timeout"],
    version: json["Version"],
    os: json["OS"],
  );

  String get getUrl => "https://cupps.abomis.com/hubs/platformHub?type=${deviceType}&device_id=${deviceId}&token=${workstationToken}&handshake_timeout=${timeout}&version=${version}&os=${os}";


  Map<String, dynamic> toJson() => {
    "DeviceID": deviceId,
    "DeviceType": deviceType,
    "WorkstationToken": workstationToken,
    "Timeout": timeout,
    "Version": version,
    "OS": os,
  };


}