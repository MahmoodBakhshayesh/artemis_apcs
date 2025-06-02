class ArtemisAcpsBoardingPass {
  final String name;
  final String title;
  final String? seq;
  final String fromCity;
  final String toCity;
  final String fromCityName;
  final String toCityName;
  final String? classType;
  final String? class_;
  final String? referenceNo;
  final String? ticketNumber;
  final String? passportNumber;
  final String? passengerType;
  final String? ssrs;
  final String? seat;
  final String? extraSeat;
  final int? baggageCount;
  final int? baggageWeight;
  final int? pieceAllowance;
  final String? weightAllowace;
  final String? excessBaggage;
  final String? excessBaggageRate;
  final String? emdInvoice;
  final String? barcodeData;
  final String? weightUnit;
  final String? agent;
  final String? apisStatus;
  final String? zone;
  final String? boardingPriorityGroup;
  final String? freeText;
  final String? remark;
  final String? airlineCode;
  final String? airlineName;
  final String? flightNumber;
  final DateTime? flightDate;
  final String? std;
  final String? sta;
  final String? btd;
  final String? gate;
  final String? departureTerminal;
  final String? documentNo;
  final String? fqtvCode;
  final int? printCount;
  final String? printTime;
  final String? pectabName;
  final String? extra1;
  final String? extra2;
  final String? extra3;
  final String? extra4;
  final String? extra5;
  final String? fromAirportName;
  final String? toAirportName;

  const ArtemisAcpsBoardingPass({
    required this.name,
    required this.title,
    this.seq,
    required this.fromCity,
    required this.toCity,
    required this.fromCityName,
    required this.toCityName,
    this.classType,
    this.class_,
    this.referenceNo,
    this.ticketNumber,
    this.passportNumber,
    this.passengerType,
    this.ssrs,
    this.seat,
    this.extraSeat,
    this.baggageCount,
    this.baggageWeight,
    this.pieceAllowance,
    this.weightAllowace,
    this.excessBaggage,
    this.excessBaggageRate,
    this.emdInvoice,
    this.barcodeData,
    this.weightUnit,
    this.agent,
    this.apisStatus,
    this.zone,
    this.boardingPriorityGroup,
    this.freeText,
    this.remark,
    this.airlineCode,
    this.airlineName,
    this.flightNumber,
    this.flightDate,
    this.std,
    this.sta,
    this.btd,
    this.gate,
    this.departureTerminal,
    this.documentNo,
    this.fqtvCode,
    this.printCount,
    this.printTime,
    this.pectabName,
    this.extra1,
    this.extra2,
    this.extra3,
    this.extra4,
    this.extra5,
    this.fromAirportName,
    this.toAirportName,
  });

  factory ArtemisAcpsBoardingPass.fromJson(Map<String, dynamic> json) {
    return ArtemisAcpsBoardingPass(
      name: json['Name'],
      title: json['Title'],
      seq: json['SEQ'],
      fromCity: json['FromCity'],
      toCity: json['ToCity'],
      fromCityName: json['FromCityName'],
      toCityName: json['ToCityName'],
      classType: json['ClassType'],
      class_: json['Class'],
      referenceNo: json['ReferenceNo'],
      ticketNumber: json['TicketNumber'],
      passportNumber: json['PassportNumber'],
      passengerType: json['PassengerType'],
      ssrs: json['SSRs'],
      seat: json['Seat'],
      extraSeat: json['ExtraSeat'],
      baggageCount: json['BaggageCount'],
      baggageWeight: json['BaggageWeight'],
      pieceAllowance: json['PieceAllowance'],
      weightAllowace: json['WeightAllowace'],
      excessBaggage: json['ExcessBaggage'],
      excessBaggageRate: json['ExcessBaggageRate'],
      emdInvoice: json['EMDinvoice'],
      barcodeData: json['BarcodeData'],
      weightUnit: json['WeightUnit'],
      agent: json['Agent'],
      apisStatus: json['APISStatus'],
      zone: json['Zone'],
      boardingPriorityGroup: json['BoardingPriorityGroup'],
      freeText: json['FreeText'],
      remark: json['Remark'],
      airlineCode: json['AirlineCode'],
      airlineName: json['AirlineName'],
      flightNumber: json['FlightNumber'],
      flightDate: json['FlightDate'] != null ? DateTime.tryParse(json['FlightDate']) : null,
      std: json['STD'],
      sta: json['STA'],
      btd: json['BTD'],
      gate: json['Gate'],
      departureTerminal: json['DepartureTerminal'],
      documentNo: json['DocumentNo'],
      fqtvCode: json['FQTVCode'],
      printCount: json['PrintCount'],
      printTime: json['PrintTime'],
      pectabName: json['PectabName'],
      extra1: json['Extra1'],
      extra2: json['Extra2'],
      extra3: json['Extra3'],
      extra4: json['Extra4'],
      extra5: json['Extra5'],
      fromAirportName: json['FromAirportName'],
      toAirportName: json['ToAirportName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Title': title,
      'SEQ': seq,
      'FromCity': fromCity,
      'ToCity': toCity,
      'FromCityName': fromCityName,
      'ToCityName': toCityName,
      'ClassType': classType,
      'Class': class_,
      'ReferenceNo': referenceNo,
      'TicketNumber': ticketNumber,
      'PassportNumber': passportNumber,
      'PassengerType': passengerType,
      'SSRs': ssrs,
      'Seat': seat,
      'ExtraSeat': extraSeat,
      'BaggageCount': baggageCount,
      'BaggageWeight': baggageWeight,
      'PieceAllowance': pieceAllowance,
      'WeightAllowace': weightAllowace,
      'ExcessBaggage': excessBaggage,
      'ExcessBaggageRate': excessBaggageRate,
      'EMDinvoice': emdInvoice,
      'BarcodeData': barcodeData,
      'WeightUnit': weightUnit,
      'Agent': agent,
      'APISStatus': apisStatus,
      'Zone': zone,
      'BoardingPriorityGroup': boardingPriorityGroup,
      'FreeText': freeText,
      'Remark': remark,
      'AirlineCode': airlineCode,
      'AirlineName': airlineName,
      'FlightNumber': flightNumber,
      'FlightDate': flightDate?.toIso8601String(),
      'STD': std,
      'STA': sta,
      'BTD': btd,
      'Gate': gate,
      'DepartureTerminal': departureTerminal,
      'DocumentNo': documentNo,
      'FQTVCode': fqtvCode,
      'PrintCount': printCount,
      'PrintTime': printTime,
      'PectabName': pectabName,
      'Extra1': extra1,
      'Extra2': extra2,
      'Extra3': extra3,
      'Extra4': extra4,
      'Extra5': extra5,
      'FromAirportName': fromAirportName,
      'ToAirportName': toAirportName,
    };
  }

  ArtemisAcpsBoardingPass copyWith({
    String? name,
    String? title,
    String? seq,
    String? fromCity,
    String? toCity,
    String? fromCityName,
    String? toCityName,
    String? classType,
    String? class_,
    String? referenceNo,
    String? ticketNumber,
    String? passportNumber,
    String? passengerType,
    String? ssrs,
    String? seat,
    String? extraSeat,
    int? baggageCount,
    int? baggageWeight,
    int? pieceAllowance,
    String? weightAllowace,
    String? excessBaggage,
    String? excessBaggageRate,
    String? emdInvoice,
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
    String? printTime,
    String? pectabName,
    String? extra1,
    String? extra2,
    String? extra3,
    String? extra4,
    String? extra5,
    String? fromAirportName,
    String? toAirportName,
  }) {
    return ArtemisAcpsBoardingPass(
      name: name ?? this.name,
      title: title ?? this.title,
      seq: seq ?? this.seq,
      fromCity: fromCity ?? this.fromCity,
      toCity: toCity ?? this.toCity,
      fromCityName: fromCityName ?? this.fromCityName,
      toCityName: toCityName ?? this.toCityName,
      classType: classType ?? this.classType,
      class_: class_ ?? this.class_,
      referenceNo: referenceNo ?? this.referenceNo,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      passportNumber: passportNumber ?? this.passportNumber,
      passengerType: passengerType ?? this.passengerType,
      ssrs: ssrs ?? this.ssrs,
      seat: seat ?? this.seat,
      extraSeat: extraSeat ?? this.extraSeat,
      baggageCount: baggageCount ?? this.baggageCount,
      baggageWeight: baggageWeight ?? this.baggageWeight,
      pieceAllowance: pieceAllowance ?? this.pieceAllowance,
      weightAllowace: weightAllowace ?? this.weightAllowace,
      excessBaggage: excessBaggage ?? this.excessBaggage,
      excessBaggageRate: excessBaggageRate ?? this.excessBaggageRate,
      emdInvoice: emdInvoice ?? this.emdInvoice,
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
  }
}
