import 'package:artemis_acps/classes/artemis_acps_bagtag_class.dart';
import 'package:artemis_acps/classes/artemis_acps_boarding_pass_class.dart';

class ArtemisAcpsAeaCommand {
  final String deviceId;
  final String? airlineCode;
  final BoardingPassCommand? boardingPass;
  final BagTagCommand? bagTag;
  final GateReaderCommand? gateReader;

  ArtemisAcpsAeaCommand({
    required this.deviceId,
    required this.airlineCode,
    this.boardingPass,
    this.bagTag,
    this.gateReader,
  });

  ArtemisAcpsAeaCommand copyWith({
    String? deviceId,
    String? airlineCode,
    BoardingPassCommand? boardingPass,
    BagTagCommand? bagTag,
    GateReaderCommand? gateReader,
  }) =>
      ArtemisAcpsAeaCommand(
        deviceId: deviceId ?? this.deviceId,
        airlineCode: airlineCode ?? this.airlineCode,
        boardingPass: boardingPass ?? this.boardingPass,
        bagTag: bagTag ?? this.bagTag,
        gateReader: gateReader ?? this.gateReader,
      );

  factory ArtemisAcpsAeaCommand.fromJson(Map<String, dynamic> json) => ArtemisAcpsAeaCommand(
    deviceId: json["DeviceID"],
    airlineCode: json["AirlineCode"],
    boardingPass: BoardingPassCommand.fromJson(json["BoardingPass"]),
    bagTag: BagTagCommand.fromJson(json["BagTag"]),
    gateReader: GateReaderCommand.fromJson(json["GateReader"]),
  );

  Map<String, dynamic> toJson() => {
    "DeviceID": deviceId,
    "AirlineCode": airlineCode,
    "BoardingPass": boardingPass?.toJson(),
    "BagTag": bagTag?.toJson(),
    "GateReader": gateReader?.toJson(),
  };
}
class BoardingPassCommand {
  final String? printerId;
  final List<AeaCommand> data;

  BoardingPassCommand({
    this.printerId,
    required this.data,
  });

  BoardingPassCommand copyWith({
    String? printerId,
    List<AeaCommand>? data,
  }) =>
      BoardingPassCommand(
        printerId: printerId ?? this.printerId,
        data: data ?? this.data,
      );

  factory BoardingPassCommand.fromJson(Map<String, dynamic> json) => BoardingPassCommand(
    printerId: json["PrinterID"],
    data: List<AeaCommand>.from(json["Data"].map((x) => AeaCommand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "PrinterID": printerId,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
class BagTagCommand {
  final String? printerId;
  final List<AeaCommand> data;

  BagTagCommand({
    this.printerId,
    required this.data,
  });

  BagTagCommand copyWith({
    String? printerId,
    List<AeaCommand>? data,
  }) =>
      BagTagCommand(
        printerId: printerId ?? this.printerId,
        data: data ?? this.data,
      );

  factory BagTagCommand.fromJson(Map<String, dynamic> json) => BagTagCommand(
    printerId: json["PrinterID"],
    data: List<AeaCommand>.from(json["Data"].map((x) => AeaCommand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "PrinterID": printerId,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
class AeaCommand {
  final String command;

  AeaCommand({
    required this.command,
  });

  AeaCommand copyWith({
    String? command,
  }) =>
      AeaCommand(
        command: command ?? this.command,
      );

  factory AeaCommand.fromJson(Map<String, dynamic> json) => AeaCommand(
    command: json["Command"],
  );

  Map<String, dynamic> toJson() => {
    "Command": command,
  };
}
class GateReaderCommand {
  final String? gateReaderId;
  final List<GateReaderAeaCommand> data;

  GateReaderCommand({
    this.gateReaderId,
    required this.data,
  });

  GateReaderCommand copyWith({
    String? gateReaderId,
    List<GateReaderAeaCommand>? data,
  }) =>
      GateReaderCommand(
        gateReaderId: gateReaderId ?? this.gateReaderId,
        data: data ?? this.data,
      );

  factory GateReaderCommand.fromJson(Map<String, dynamic> json) => GateReaderCommand(
    gateReaderId: json["GateReaderID"],
    data: List<GateReaderAeaCommand>.from(json["Data"].map((x) => GateReaderAeaCommand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "GateReaderID": gateReaderId,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
class GateReaderAeaCommand {
  final String command;
  final String message;
  final dynamic isSuccess;

  GateReaderAeaCommand({
    required this.command,
    required this.message,
    required this.isSuccess,
  });

  GateReaderAeaCommand copyWith({
    String? command,
    String? message,
    dynamic isSuccess,
  }) =>
      GateReaderAeaCommand(
        command: command ?? this.command,
        message: message ?? this.message,
        isSuccess: isSuccess ?? this.isSuccess,
      );

  factory GateReaderAeaCommand.fromJson(Map<String, dynamic> json) => GateReaderAeaCommand(
    command: json["Command"],
    message: json["Message"],
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Command": command,
    "Message": message,
    "IsSuccess": isSuccess,
  };
}
class PrCommand {
  final String deviceId;
  final String data;
  final String? printerId;

  PrCommand({
    required this.deviceId,
    required this.data,
    this.printerId,
  });

  PrCommand copyWith({
    String? deviceId,
    String? data,
    String? printerId,
  }) =>
      PrCommand(
        deviceId: deviceId ?? this.deviceId,
        data: data ?? this.data,
        printerId: printerId ?? this.printerId,
      );

  factory PrCommand.fromJson(Map<String, dynamic> json) => PrCommand(
    deviceId: json["DeviceID"],
    data: json["Data"],
    printerId: json["PrinterID"],
  );

  Map<String, dynamic> toJson() => {
    "DeviceID": deviceId,
    "Data": data,
    "PrinterID": printerId,
  };
}

class ArtemisAcpsAeaResponse {
  final String deviceId;
  final String? id;
  final String deviceName;
  final String transactionId;
  final String printerType;
  final String description;
  final bool isSuccessful;
  final String? seq;
  final String? flightNumber;
  final String? name;
  final String? callbackUrl;
  final String? message;
  final DateTime printResponseDateTime;

  ArtemisAcpsAeaResponse({
    required this.deviceId,
    required this.id,
    required this.deviceName,
    required this.transactionId,
    required this.printerType,
    required this.description,
    required this.isSuccessful,
    required this.seq,
    required this.flightNumber,
    required this.name,
    required this.callbackUrl,
    required this.message,
    required this.printResponseDateTime,
  });

  ArtemisAcpsAeaResponse copyWith({
    String? deviceId,
    String? id,
    String? deviceName,
    String? transactionId,
    String? printerType,
    String? description,
    bool? isSuccessful,
    String? seq,
    String? flightNumber,
    String? name,
    String? callbackUrl,
    String? message,
    DateTime? printResponseDateTime,
  }) =>
      ArtemisAcpsAeaResponse(
        deviceId: deviceId ?? this.deviceId,
        id: id ?? this.id,
        deviceName: deviceName ?? this.deviceName,
        transactionId: transactionId ?? this.transactionId,
        printerType: printerType ?? this.printerType,
        description: description ?? this.description,
        isSuccessful: isSuccessful ?? this.isSuccessful,
        seq: seq ?? this.seq,
        flightNumber: flightNumber ?? this.flightNumber,
        name: name ?? this.name,
        callbackUrl: callbackUrl ?? this.callbackUrl,
        message: message ?? this.message,
        printResponseDateTime: printResponseDateTime ?? this.printResponseDateTime,
      );

  factory ArtemisAcpsAeaResponse.fromJson(Map<String, dynamic> json) => ArtemisAcpsAeaResponse(
    deviceId: json["deviceID"],
    id: json["id"],
    deviceName: json["deviceName"]??'',
    transactionId: json["transactionID"],
    printerType: json["printerType"],
    description: json["description"],
    isSuccessful: json["isSuccessful"],
    seq: json["seq"],
    flightNumber: json["flightNumber"],
    name: json["name"],
    callbackUrl: json["callbackUrl"],
    message: json["message"],
    printResponseDateTime: DateTime.parse(json["printResponseDateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "deviceID": deviceId,
    "id": id,
    "deviceName": deviceName,
    "transactionID": transactionId,
    "printerType": printerType,
    "description": description,
    "isSuccessful": isSuccessful,
    "seq": seq,
    "flightNumber": flightNumber,
    "name": name,
    "callbackUrl": callbackUrl,
    "message": message,
    "printResponseDateTime": printResponseDateTime.toIso8601String(),
  };
}

class ArtemisAcpsReceivedData {
  final String data;
  final String deviceType;
  final String deviceName;
  final String deviceId;
  final DateTime readTime;

  ArtemisAcpsReceivedData({
    required this.data,
    required this.deviceType,
    required this.deviceName,
    required this.deviceId,
    required this.readTime,
  });

  ArtemisAcpsReceivedData copyWith({
    String? data,
    String? deviceType,
    String? deviceName,
    String? deviceId,
    DateTime? readTime,
  }) =>
      ArtemisAcpsReceivedData(
        data: data ?? this.data,
        deviceType: deviceType ?? this.deviceType,
        deviceName: deviceName ?? this.deviceName,
        deviceId: deviceId ?? this.deviceId,
        readTime: readTime ?? this.readTime,
      );

  factory ArtemisAcpsReceivedData.fromJson(Map<String, dynamic> json) => ArtemisAcpsReceivedData(
    data: json["data"],
    deviceType: json["deviceType"],
    deviceName: json["deviceName"],
    deviceId: json["deviceID"],
    readTime: DateTime.parse(json["readTime"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "deviceType": deviceType,
    "deviceName": deviceName,
    "deviceID": deviceId,
    "readTime": readTime.toIso8601String(),
  };
}


class ArtemisAcpsDirectCommand {
  final String deviceId;
  final String airlineCode;
  final BoardingPassDirect boardingPass;
  final BagTagDirect bagTag;

  ArtemisAcpsDirectCommand({
    required this.deviceId,
    required this.airlineCode,
    required this.boardingPass,
    required this.bagTag,
  });

  ArtemisAcpsDirectCommand copyWith({
    String? deviceId,
    dynamic airlineCode,
    BoardingPassDirect? boardingPass,
    BagTagDirect? bagTag,
  }) =>
      ArtemisAcpsDirectCommand(
        deviceId: deviceId ?? this.deviceId,
        airlineCode: airlineCode ?? this.airlineCode,
        boardingPass: boardingPass ?? this.boardingPass,
        bagTag: bagTag ?? this.bagTag,
      );

  factory ArtemisAcpsDirectCommand.fromJson(Map<String, dynamic> json) => ArtemisAcpsDirectCommand(
    deviceId: json["DeviceID"],
    airlineCode: json["AirlineCode"],
    boardingPass: BoardingPassDirect.fromJson(json["BoardingPass"]),
    bagTag: BagTagDirect.fromJson(json["BagTag"]),
  );

  Map<String, dynamic> toJson() => {
    "DeviceID": deviceId,
    "AirlineCode": airlineCode,
    "BoardingPass": boardingPass.toJson(),
    "BagTag": bagTag.toJson(),
  };
}

class BagTagDirect {
  final String? printerId;
  final List<ArtemisAcpsBagtag> data;

  BagTagDirect({
    required this.printerId,
    required this.data,
  });

  BagTagDirect copyWith({
    String? printerId,
    List<ArtemisAcpsBagtag>? data,
  }) =>
      BagTagDirect(
        printerId: printerId ?? this.printerId,
        data: data ?? this.data,
      );

  factory BagTagDirect.fromJson(Map<String, dynamic> json) => BagTagDirect(
    printerId: json["PrinterID"],
    data: List<ArtemisAcpsBagtag>.from(json["Data"].map((x) => ArtemisAcpsBagtag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "PrinterID": printerId,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}


class BoardingPassDirect {
  final String? printerId;
  final List<ArtemisAcpsBoardingPass> data;

  BoardingPassDirect({
    required this.printerId,
    required this.data,
  });

  BoardingPassDirect copyWith({
    String? printerId,
    List<ArtemisAcpsBoardingPass>? data,
  }) =>
      BoardingPassDirect(
        printerId: printerId ?? this.printerId,
        data: data ?? this.data,
      );

  factory BoardingPassDirect.fromJson(Map<String, dynamic> json) => BoardingPassDirect(
    printerId: json["PrinterID"],
    data: List<ArtemisAcpsBoardingPass>.from(json["Data"].map((x) => ArtemisAcpsBoardingPass.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "PrinterID": printerId,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

