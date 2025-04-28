// To parse this JSON data, do
//
//     final artemisAcpsBoardingPass = artemisAcpsBoardingPassFromJson(jsonString);

import 'dart:convert';

ArtemisAcpsBoardingPass artemisAcpsBoardingPassFromJson(String str) => ArtemisAcpsBoardingPass.fromJson(json.decode(str));

String artemisAcpsBoardingPassToJson(ArtemisAcpsBoardingPass data) => json.encode(data.toJson());

class ArtemisAcpsBoardingPass {
  final String name;
  final String title;
  final String seq;
  final String fromCity;
  final String toCity;
  final String fromCityName;
  final String toCityName;
  final String classType;
  final String artemisAcpsBoardingPassClass;
  final String referenceNo;
  final String? ticketNumber;
  final String? passportNumber;
  final String passengerType;
  final String? ssRs;
  final String seat;
  final String? extraSeat;
  final int baggageCount;
  final int baggageWeight;
  final int pieceAllowance;
  final String weightAllowace;
  final String? excessBaggage;
  final String? excessBaggageRate;
  final String? emDinvoice;
  final String barcodeData;
  final String weightUnit;
  final String agent;
  final String apisStatus;
  final String zone;
  final String boardingPriorityGroup;
  final String freeText;
  final String remark;
  final String airlineCode;
  final String airlineName;
  final String flightNumber;
  final DateTime flightDate;
  final String std;
  final String sta;
  final String btd;
  final String gate;
  final String departureTerminal;
  final String documentNo;
  final String fqtvCode;
  final int printCount;
  final String? printTime;
  final String pectabName;
  final String? extra1;
  final String? extra2;
  final String? extra3;
  final String? extra4;
  final String? extra5;
  final String? fromAirportName;
  final String? toAirportName;

  ArtemisAcpsBoardingPass({
    required this.name,
    required this.title,
    required this.seq,
    required this.fromCity,
    required this.toCity,
    this.fromCityName='',
    this.toCityName='',
    required this.classType,
    this.artemisAcpsBoardingPassClass='',
    this.referenceNo='',
    this.ticketNumber,
    this.passportNumber,
    required this.passengerType,
    this.ssRs,
    required this.seat,
    this.extraSeat,
    required this.baggageCount,
    required this.baggageWeight,
    this.pieceAllowance=1,
    this.weightAllowace='',
    this.excessBaggage,
    this.excessBaggageRate,
    this.emDinvoice,
    required this.barcodeData,
    this.weightUnit="",
    this.agent='',
    this.apisStatus='',
    this.zone='',
    this.boardingPriorityGroup='',
    this.freeText='',
    this.remark='',
    required this.airlineCode,
    required this.airlineName,
    required this.flightNumber,
    required this.flightDate,
    required this.std,
    this.sta='',
    required this.btd,
    required this.gate,
     this.departureTerminal="",
     this.documentNo='',
     this.fqtvCode='',
     this.printCount=1,
    this.printTime,
     this.pectabName ='',
     this.extra1,
     this.extra2,
    this.extra3,
    this.extra4,
    this.extra5,
    this.fromAirportName,
    this.toAirportName,
  });

  ArtemisAcpsBoardingPass copyWith({
    String? name,
    String? title,
    String? seq,
    String? fromCity,
    String? toCity,
    String? fromCityName,
    String? toCityName,
    String? classType,
    String? artemisAcpsBoardingPassClass,
    String? referenceNo,
    dynamic ticketNumber,
    dynamic passportNumber,
    String? passengerType,
    dynamic ssRs,
    String? seat,
    dynamic extraSeat,
    int? baggageCount,
    int? baggageWeight,
    int? pieceAllowance,
    String? weightAllowace,
    dynamic excessBaggage,
    dynamic excessBaggageRate,
    dynamic emDinvoice,
    String? barcodeData,
    String? weightUnit,
    String? agent,
    String? apisStatus,
    String? zone,
    String? boardingPriorityGroup,
    String? freeText,
    String? remark,
    String? airlineCode,
    String? airlineName,
    String? flightNumber,
    DateTime? flightDate,
    String? std,
    String? sta,
    String? btd,
    String? gate,
    String? departureTerminal,
    String? documentNo,
    String? fqtvCode,
    int? printCount,
    dynamic printTime,
    String? pectabName,
    dynamic extra1,
    dynamic extra2,
    dynamic extra3,
    dynamic extra4,
    dynamic extra5,
    dynamic fromAirportName,
    dynamic toAirportName,
  }) => ArtemisAcpsBoardingPass(
    name: name ?? this.name,
    title: title ?? this.title,
    seq: seq ?? this.seq,
    fromCity: fromCity ?? this.fromCity,
    toCity: toCity ?? this.toCity,
    fromCityName: fromCityName ?? this.fromCityName,
    toCityName: toCityName ?? this.toCityName,
    classType: classType ?? this.classType,
    artemisAcpsBoardingPassClass: artemisAcpsBoardingPassClass ?? this.artemisAcpsBoardingPassClass,
    referenceNo: referenceNo ?? this.referenceNo,
    ticketNumber: ticketNumber ?? this.ticketNumber,
    passportNumber: passportNumber ?? this.passportNumber,
    passengerType: passengerType ?? this.passengerType,
    ssRs: ssRs ?? this.ssRs,
    seat: seat ?? this.seat,
    extraSeat: extraSeat ?? this.extraSeat,
    baggageCount: baggageCount ?? this.baggageCount,
    baggageWeight: baggageWeight ?? this.baggageWeight,
    pieceAllowance: pieceAllowance ?? this.pieceAllowance,
    weightAllowace: weightAllowace ?? this.weightAllowace,
    excessBaggage: excessBaggage ?? this.excessBaggage,
    excessBaggageRate: excessBaggageRate ?? this.excessBaggageRate,
    emDinvoice: emDinvoice ?? this.emDinvoice,
    barcodeData: barcodeData ?? this.barcodeData,
    weightUnit: weightUnit ?? this.weightUnit,
    agent: agent ?? this.agent,
    apisStatus: apisStatus ?? this.apisStatus,
    zone: zone ?? this.zone,
    boardingPriorityGroup: boardingPriorityGroup ?? this.boardingPriorityGroup,
    freeText: freeText ?? this.freeText,
    remark: remark ?? this.remark,
    airlineCode: airlineCode ?? this.airlineCode,
    airlineName: airlineName ?? this.airlineName,
    flightNumber: flightNumber ?? this.flightNumber,
    flightDate: flightDate ?? this.flightDate,
    std: std ?? this.std,
    sta: sta ?? this.sta,
    btd: btd ?? this.btd,
    gate: gate ?? this.gate,
    departureTerminal: departureTerminal ?? this.departureTerminal,
    documentNo: documentNo ?? this.documentNo,
    fqtvCode: fqtvCode ?? this.fqtvCode,
    printCount: printCount ?? this.printCount,
    printTime: printTime ?? this.printTime,
    pectabName: pectabName ?? this.pectabName,
    extra1: extra1 ?? this.extra1,
    extra2: extra2 ?? this.extra2,
    extra3: extra3 ?? this.extra3,
    extra4: extra4 ?? this.extra4,
    extra5: extra5 ?? this.extra5,
    fromAirportName: fromAirportName ?? this.fromAirportName,
    toAirportName: toAirportName ?? this.toAirportName,
  );

  factory ArtemisAcpsBoardingPass.fromJson(Map<String, dynamic> json) => ArtemisAcpsBoardingPass(
    name: json["Name"],
    title: json["Title"],
    seq: json["SEQ"],
    fromCity: json["FromCity"],
    toCity: json["ToCity"],
    fromCityName: json["FromCityName"],
    toCityName: json["ToCityName"],
    classType: json["ClassType"],
    artemisAcpsBoardingPassClass: json["Class"],
    referenceNo: json["ReferenceNo"],
    ticketNumber: json["TicketNumber"],
    passportNumber: json["PassportNumber"],
    passengerType: json["PassengerType"],
    ssRs: json["SSRs"],
    seat: json["Seat"],
    extraSeat: json["ExtraSeat"],
    baggageCount: json["BaggageCount"],
    baggageWeight: json["BaggageWeight"],
    pieceAllowance: json["PieceAllowance"],
    weightAllowace: json["WeightAllowace"],
    excessBaggage: json["ExcessBaggage"],
    excessBaggageRate: json["ExcessBaggageRate"],
    emDinvoice: json["EMDinvoice"],
    barcodeData: json["BarcodeData"],
    weightUnit: json["WeightUnit"],
    agent: json["Agent"],
    apisStatus: json["APISStatus"],
    zone: json["Zone"],
    boardingPriorityGroup: json["BoardingPriorityGroup"],
    freeText: json["FreeText"],
    remark: json["Remark"],
    airlineCode: json["AirlineCode"],
    airlineName: json["AirlineName"],
    flightNumber: json["FlightNumber"],
    flightDate: DateTime.parse(json["FlightDate"]),
    std: json["STD"],
    sta: json["STA"],
    btd: json["BTD"],
    gate: json["Gate"],
    departureTerminal: json["DepartureTerminal"],
    documentNo: json["DocumentNo"],
    fqtvCode: json["FQTVCode"],
    printCount: json["PrintCount"],
    printTime: json["PrintTime"],
    pectabName: json["PectabName"],
    extra1: json["Extra1"],
    extra2: json["Extra2"],
    extra3: json["Extra3"],
    extra4: json["Extra4"],
    extra5: json["Extra5"],
    fromAirportName: json["FromAirportName"],
    toAirportName: json["ToAirportName"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Title": title,
    "SEQ": seq,
    "FromCity": fromCity,
    "ToCity": toCity,
    "FromCityName": fromCityName,
    "ToCityName": toCityName,
    "ClassType": classType,
    "Class": artemisAcpsBoardingPassClass,
    "ReferenceNo": referenceNo,
    "TicketNumber": ticketNumber,
    "PassportNumber": passportNumber,
    "PassengerType": passengerType,
    "SSRs": ssRs,
    "Seat": seat,
    "ExtraSeat": extraSeat,
    "BaggageCount": baggageCount,
    "BaggageWeight": baggageWeight,
    "PieceAllowance": pieceAllowance,
    "WeightAllowace": weightAllowace,
    "ExcessBaggage": excessBaggage,
    "ExcessBaggageRate": excessBaggageRate,
    "EMDinvoice": emDinvoice,
    "BarcodeData": barcodeData,
    "WeightUnit": weightUnit,
    "Agent": agent,
    "APISStatus": apisStatus,
    "Zone": zone,
    "BoardingPriorityGroup": boardingPriorityGroup,
    "FreeText": freeText,
    "Remark": remark,
    "AirlineCode": airlineCode,
    "AirlineName": airlineName,
    "FlightNumber": flightNumber,
    "FlightDate": "${flightDate.year.toString().padLeft(4, '0')}-${flightDate.month.toString().padLeft(2, '0')}-${flightDate.day.toString().padLeft(2, '0')}",
    "STD": std,
    "STA": sta,
    "BTD": btd,
    "Gate": gate,
    "DepartureTerminal": departureTerminal,
    "DocumentNo": documentNo,
    "FQTVCode": fqtvCode,
    "PrintCount": printCount,
    "PrintTime": printTime,
    "PectabName": pectabName,
    "Extra1": extra1,
    "Extra2": extra2,
    "Extra3": extra3,
    "Extra4": extra4,
    "Extra5": extra5,
    "FromAirportName": fromAirportName,
    "ToAirportName": toAirportName,
  };

  String get firstName => name.replaceAll("/", ' ').split(" ").first;

  String get lastName => name.replaceAll("/", ' ').split(" ").last;

  String get barcode => "M1TEST PRINT          98765432AAABBB6E 9999 293Y1A  1    100";
}
