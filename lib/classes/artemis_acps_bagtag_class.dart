class ArtemisAcpsBagtag {
  String tagNumber;
  String sixDigitNumber;
  String name;
  String referenceNo;
  String airlineThreeDigitCode;
  String tagType;
  int baggageCount;
  int baggageWeight;
  String weightUnit;
  String limitType;
  String agent;
  String firstAirportCode;
  String firstAirportName;
  String lastSeq;
  String lastArilineCode;
  String lastAirlineName;
  String lastFlightNumber;
  String lastFlightDate;
  String lastAirportCode;
  String lastAirportName;
  String lastClassType;
  String lastclass;
  String via1Seq;
  String via1ArilineCode;
  String via1AirlineName;
  String via1FlightNumber;
  String via1FlightDate;
  String via1AirportCode;
  String via1AirportName;
  String via1ClassType;
  String via1Class;
  String via2Seq;
  String via2ArilineCode;
  String via2AirlineName;
  String via2FlightNumber;
  String via2FlightDate;
  String via2AirportCode;
  String via2AirportName;
  String via2ClassType;
  String via2Class;
  String? printTime;
  String? lastStd;
  String? via1Std;
  String? via2Std;
  String pectabName;
  String? firstCityName;
  String? lastCityName;
  String? via1CityName;
  String? via2CityName;
  String? extra1;
  String? extra2;
  String? extra3;
  String? extra4;
  String? extra5;
  String? freeText;

  ArtemisAcpsBagtag({
    required this.tagNumber,
    required this.sixDigitNumber,
    required this.name,
    required this.referenceNo,
    required this.airlineThreeDigitCode,
    this.tagType ='',
    required this.baggageCount,
    required this.baggageWeight,
    required this.weightUnit,
    this.limitType ='',
    this.agent='',
    required this.firstAirportCode,
    required this.firstAirportName,
    this.lastSeq='',
    required this.lastArilineCode,
    required this.lastAirlineName,
    required this.lastFlightNumber,
    required this.lastFlightDate,
    required this.lastAirportCode,
    required this.lastAirportName,
    required this.lastClassType,
    required this.lastclass,
    this.via1Seq='',
    this.via1ArilineCode='',
    this.via1AirlineName='',
    this.via1FlightNumber='',
    this.via1FlightDate='',
    this.via1AirportCode='',
    this.via1AirportName='',
    this.via1ClassType='',
    this.via1Class='',
    this.via2Seq='',
    this.via2ArilineCode='',
    this.via2AirlineName='',
    this.via2FlightNumber='',
    this.via2FlightDate='',
    this.via2AirportCode='',
    this.via2AirportName='',
    this.via2ClassType='',
    this.via2Class='',
    this.printTime,
    this.lastStd,
    this.via1Std,
    this.via2Std,
    this.pectabName='',
    this.firstCityName,
    this.lastCityName,
    this.via1CityName,
    this.via2CityName,
    this.extra1,
    this.extra2,
    this.extra3,
    this.extra4,
    this.extra5,
    this.freeText,
  });

  ArtemisAcpsBagtag copyWith({
    String? tagNumber,
    String? sixDigitNumber,
    String? name,
    String? referenceNo,
    String? airlineThreeDigitCode,
    String? tagType,
    int? baggageCount,
    int? baggageWeight,
    String? weightUnit,
    String? limitType,
    String? agent,
    String? firstAirportCode,
    String? firstAirportName,
    String? lastSeq,
    String? lastArilineCode,
    String? lastAirlineName,
    String? lastFlightNumber,
    String? lastFlightDate,
    String? lastAirportCode,
    String? lastAirportName,
    String? lastClassType,
    String? lastclass,
    String? via1Seq,
    String? via1ArilineCode,
    String? via1AirlineName,
    String? via1FlightNumber,
    String? via1FlightDate,
    String? via1AirportCode,
    String? via1AirportName,
    String? via1ClassType,
    String? via1Class,
    String? via2Seq,
    String? via2ArilineCode,
    String? via2AirlineName,
    String? via2FlightNumber,
    String? via2FlightDate,
    String? via2AirportCode,
    String? via2AirportName,
    String? via2ClassType,
    String? via2Class,
    dynamic printTime,
    dynamic lastStd,
    dynamic via1Std,
    dynamic via2Std,
    String? pectabName,
    dynamic firstCityName,
    dynamic lastCityName,
    dynamic via1CityName,
    dynamic via2CityName,
    dynamic extra1,
    dynamic extra2,
    dynamic extra3,
    dynamic extra4,
    dynamic extra5,
    dynamic freeText,
  }) =>
      ArtemisAcpsBagtag(
        tagNumber: tagNumber ?? this.tagNumber,
        sixDigitNumber: sixDigitNumber ?? this.sixDigitNumber,
        name: name ?? this.name,
        referenceNo: referenceNo ?? this.referenceNo,
        airlineThreeDigitCode: airlineThreeDigitCode ?? this.airlineThreeDigitCode,
        tagType: tagType ?? this.tagType,
        baggageCount: baggageCount ?? this.baggageCount,
        baggageWeight: baggageWeight ?? this.baggageWeight,
        weightUnit: weightUnit ?? this.weightUnit,
        limitType: limitType ?? this.limitType,
        agent: agent ?? this.agent,
        firstAirportCode: firstAirportCode ?? this.firstAirportCode,
        firstAirportName: firstAirportName ?? this.firstAirportName,
        lastSeq: lastSeq ?? this.lastSeq,
        lastArilineCode: lastArilineCode ?? this.lastArilineCode,
        lastAirlineName: lastAirlineName ?? this.lastAirlineName,
        lastFlightNumber: lastFlightNumber ?? this.lastFlightNumber,
        lastFlightDate: lastFlightDate ?? this.lastFlightDate,
        lastAirportCode: lastAirportCode ?? this.lastAirportCode,
        lastAirportName: lastAirportName ?? this.lastAirportName,
        lastClassType: lastClassType ?? this.lastClassType,
        lastclass: lastclass ?? this.lastclass,
        via1Seq: via1Seq ?? this.via1Seq,
        via1ArilineCode: via1ArilineCode ?? this.via1ArilineCode,
        via1AirlineName: via1AirlineName ?? this.via1AirlineName,
        via1FlightNumber: via1FlightNumber ?? this.via1FlightNumber,
        via1FlightDate: via1FlightDate ?? this.via1FlightDate,
        via1AirportCode: via1AirportCode ?? this.via1AirportCode,
        via1AirportName: via1AirportName ?? this.via1AirportName,
        via1ClassType: via1ClassType ?? this.via1ClassType,
        via1Class: via1Class ?? this.via1Class,
        via2Seq: via2Seq ?? this.via2Seq,
        via2ArilineCode: via2ArilineCode ?? this.via2ArilineCode,
        via2AirlineName: via2AirlineName ?? this.via2AirlineName,
        via2FlightNumber: via2FlightNumber ?? this.via2FlightNumber,
        via2FlightDate: via2FlightDate ?? this.via2FlightDate,
        via2AirportCode: via2AirportCode ?? this.via2AirportCode,
        via2AirportName: via2AirportName ?? this.via2AirportName,
        via2ClassType: via2ClassType ?? this.via2ClassType,
        via2Class: via2Class ?? this.via2Class,
        printTime: printTime ?? this.printTime,
        lastStd: lastStd ?? this.lastStd,
        via1Std: via1Std ?? this.via1Std,
        via2Std: via2Std ?? this.via2Std,
        pectabName: pectabName ?? this.pectabName,
        firstCityName: firstCityName ?? this.firstCityName,
        lastCityName: lastCityName ?? this.lastCityName,
        via1CityName: via1CityName ?? this.via1CityName,
        via2CityName: via2CityName ?? this.via2CityName,
        extra1: extra1 ?? this.extra1,
        extra2: extra2 ?? this.extra2,
        extra3: extra3 ?? this.extra3,
        extra4: extra4 ?? this.extra4,
        extra5: extra5 ?? this.extra5,
        freeText: freeText ?? this.freeText,
      );

  factory ArtemisAcpsBagtag.fromJson(Map<String, dynamic> json) => ArtemisAcpsBagtag(
    tagNumber: json["TagNumber"],
    sixDigitNumber: json["SixDigitNumber"],
    name: json["Name"],
    referenceNo: json["ReferenceNo"],
    airlineThreeDigitCode: json["AirlineThreeDigitCode"],
    tagType: json["TagType"],
    baggageCount: json["BaggageCount"],
    baggageWeight: json["BaggageWeight"],
    weightUnit: json["WeightUnit"],
    limitType: json["LimitType"],
    agent: json["Agent"],
    firstAirportCode: json["FirstAirportCode"],
    firstAirportName: json["FirstAirportName"],
    lastSeq: json["LastSEQ"],
    lastArilineCode: json["LastArilineCode"],
    lastAirlineName: json["LastAirlineName"],
    lastFlightNumber: json["LastFlightNumber"],
    lastFlightDate: json["LastFlightDate"],
    lastAirportCode: json["LastAirportCode"],
    lastAirportName: json["LastAirportName"],
    lastClassType: json["LastClassType"],
    lastclass: json["Lastclass"],
    via1Seq: json["Via1SEQ"],
    via1ArilineCode: json["Via1ArilineCode"],
    via1AirlineName: json["Via1AirlineName"],
    via1FlightNumber: json["Via1FlightNumber"],
    via1FlightDate: json["Via1FlightDate"],
    via1AirportCode: json["Via1AirportCode"],
    via1AirportName: json["Via1AirportName"],
    via1ClassType: json["Via1ClassType"],
    via1Class: json["Via1Class"],
    via2Seq: json["Via2SEQ"],
    via2ArilineCode: json["Via2ArilineCode"],
    via2AirlineName: json["Via2AirlineName"],
    via2FlightNumber: json["Via2FlightNumber"],
    via2FlightDate: json["Via2FlightDate"],
    via2AirportCode: json["Via2AirportCode"],
    via2AirportName: json["Via2AirportName"],
    via2ClassType: json["Via2ClassType"],
    via2Class: json["Via2Class"],
    printTime: json["PrintTime"],
    lastStd: json["LastSTD"],
    via1Std: json["Via1STD"],
    via2Std: json["Via2STD"],
    pectabName: json["PectabName"],
    firstCityName: json["FirstCityName"],
    lastCityName: json["LastCityName"],
    via1CityName: json["Via1CityName"],
    via2CityName: json["Via2CityName"],
    extra1: json["Extra1"],
    extra2: json["Extra2"],
    extra3: json["Extra3"],
    extra4: json["Extra4"],
    extra5: json["Extra5"],
    freeText: json["FreeText"],
  );

  Map<String, dynamic> toJson() => {
    "TagNumber": tagNumber,
    "SixDigitNumber": sixDigitNumber,
    "Name": name,
    "ReferenceNo": referenceNo,
    "AirlineThreeDigitCode": airlineThreeDigitCode,
    "TagType": tagType,
    "BaggageCount": baggageCount,
    "BaggageWeight": baggageWeight,
    "WeightUnit": weightUnit,
    "LimitType": limitType,
    "Agent": agent,
    "FirstAirportCode": firstAirportCode,
    "FirstAirportName": firstAirportName,
    "LastSEQ": lastSeq,
    "LastArilineCode": lastArilineCode,
    "LastAirlineName": lastAirlineName,
    "LastFlightNumber": lastFlightNumber,
    "LastFlightDate": lastFlightDate,
    "LastAirportCode": lastAirportCode,
    "LastAirportName": lastAirportName,
    "LastClassType": lastClassType,
    "Lastclass": lastclass,
    "Via1SEQ": via1Seq,
    "Via1ArilineCode": via1ArilineCode,
    "Via1AirlineName": via1AirlineName,
    "Via1FlightNumber": via1FlightNumber,
    "Via1FlightDate": via1FlightDate,
    "Via1AirportCode": via1AirportCode,
    "Via1AirportName": via1AirportName,
    "Via1ClassType": via1ClassType,
    "Via1Class": via1Class,
    "Via2SEQ": via2Seq,
    "Via2ArilineCode": via2ArilineCode,
    "Via2AirlineName": via2AirlineName,
    "Via2FlightNumber": via2FlightNumber,
    "Via2FlightDate": via2FlightDate,
    "Via2AirportCode": via2AirportCode,
    "Via2AirportName": via2AirportName,
    "Via2ClassType": via2ClassType,
    "Via2Class": via2Class,
    "PrintTime": printTime,
    "LastSTD": lastStd,
    "Via1STD": via1Std,
    "Via2STD": via2Std,
    "PectabName": pectabName,
    "FirstCityName": firstCityName,
    "LastCityName": lastCityName,
    "Via1CityName": via1CityName,
    "Via2CityName": via2CityName,
    "Extra1": extra1,
    "Extra2": extra2,
    "Extra3": extra3,
    "Extra4": extra4,
    "Extra5": extra5,
    "FreeText": freeText,
  };
}
