import 'dart:developer';

import '../enums/acps_print_type_enum.dart';

class ArtemisKioskDevice {
  final String deviceName;
  final String status;
  final int type;

  ArtemisKioskDevice({
    required this.deviceName,
    required this.status,
    required this.type,
  });

  ArtemisKioskDevice copyWith({
    String? deviceName,
    String? status,
    int? type,
  }) =>
      ArtemisKioskDevice(
        deviceName: deviceName ?? this.deviceName,
        status: status ?? this.status,
        type: type ?? this.type,
      );

  factory ArtemisKioskDevice.fromJson(Map<String, dynamic> json) => ArtemisKioskDevice(
    deviceName: json["deviceName"],
    status: json["status"],
    type: json["type"]??0,
  );

  Map<String, dynamic> toJson() => {
    "deviceName": deviceName,
    "status": status,
    "type": type,
  };

  String get img {
    String address= "assets/images/devices/$status/${deviceName.substring(0,2).toUpperCase()}.${status=="printing"?"gif":"png"}";
    // log(address);
    return address;
  }


  String get getType {
    return deviceName.substring(0,2).toUpperCase();
  }
  AcpsPrintType get getMode {
    return type == 0?AcpsPrintType.aea:AcpsPrintType.zpl;
  }
  int get number {
    return int.tryParse(deviceName.replaceAll(RegExp(r"\D"), ""))??0;
  }

  @override
  bool operator ==(Object other) {

    return other is ArtemisKioskDevice && other.deviceName == deviceName;
  }

  @override
  int get hashCode => deviceName.hashCode;

  bool get canPrint => ["ready","printing","init"].contains(status);
}