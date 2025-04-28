import 'package:artemis_acps/extensions/list_ext.dart';

import 'artemis_kiosk_device_class.dart';

class ArtemisAcpsKiosk {
  final String deviceId;
  final bool online;
  final List<ArtemisKioskDevice> devices;

  ArtemisAcpsKiosk({required this.deviceId, required this.online, required this.devices});

  ArtemisAcpsKiosk copyWith({String? deviceId, bool? online, List<ArtemisKioskDevice>? devices}) => ArtemisAcpsKiosk(deviceId: deviceId ?? this.deviceId, online: online ?? this.online, devices: devices ?? this.devices);

  factory ArtemisAcpsKiosk.fromJson(Map<String, dynamic> json) =>
      ArtemisAcpsKiosk(deviceId: json["deviceID"], online: json["online"] ?? false, devices: List<ArtemisKioskDevice>.from(json["devices"].map((x) => ArtemisKioskDevice.fromJson(x))));

  Map<String, dynamic> toJson() => {"deviceID": deviceId, "online": online, "devices": List<dynamic>.from(devices.map((x) => x.toJson()))};

  ArtemisKioskDevice? get getBP => devices.firstWhereOrNull((e) => e.getType == "BP");

  ArtemisKioskDevice? get getBT => devices.firstWhereOrNull((e) => e.getType == "BT");
}
