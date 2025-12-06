import 'package:artemis_acps/classes/artemis_acps_bagtag_class.dart';
import 'package:artemis_acps/classes/artemis_acps_boarding_pass_class.dart';

class ArtemisAcpsBroadcastData {
  final String deviceId;
  final String? workstationToken;
  final String? transactionId;
  final String? message;
  final String? deviceType;
  final String? messageType;

  ArtemisAcpsBroadcastData({
    required this.deviceId,
    required this.workstationToken,
    this.transactionId,
    this.message,
    this.deviceType,
    this.messageType,
  });

  ArtemisAcpsBroadcastData copyWith({
    String? deviceId,
    String? workstationToken,
    String? transactionId,
    String? message,
    String? messageType,
    String? deviceType,
  }) =>
      ArtemisAcpsBroadcastData(
        deviceId: deviceId ?? this.deviceId,
        workstationToken: workstationToken ?? this.workstationToken,
        transactionId: transactionId ?? this.transactionId,
        message: message ?? this.message,
        messageType: messageType ??this.messageType,
        deviceType: deviceType ?? this.deviceType,
      );

  factory ArtemisAcpsBroadcastData.fromJson(Map<String, dynamic> json) => ArtemisAcpsBroadcastData(
    deviceId: json["DeviceID"],
    workstationToken: json["WorkstationToken"],
    transactionId: json["TransactionId"],
    message: json["Message"],
    messageType: json["MessageType"],
    deviceType: json["DeviceType"]
  );

  String get devId=> "$deviceId-${deviceType}";

  Map<String, dynamic> toJson() => {
    "DeviceID": devId,
    "WorkstationToken": workstationToken,
    "TransactionId": transactionId,
    "Message": message,
    "MessageType": messageType,
    "DeviceType": deviceType,
  };
}


