class ArtemisAcpsBagtag {
  final String? tagNumber;
  final String? sixDigitNumber;
  final String? name;
  final String? referenceNo;
  final String? airlineThreeDigitCode;
  final String? tagType;
  final int? baggageCount;
  final int? baggageWeight;
  final String? weightUnit;
  final String? limitType;
  final String? agent;
  final String? firstAirportCode;
  final String? firstAirportName;
  final String? lastSEQ;
  final String? lastAirlineCode;
  final String? lastAirlineName;
  final String? lastFlightNumber;
  final String? lastFlightDate;
  final String? lastAirportCode;
  final String? lastAirportName;
  final String? lastClassType;
  final String? lastClass;
  final String? via1SEQ;
  final String? via1AirlineCode;
  final String? via1AirlineName;
  final String? via1FlightNumber;
  final String? via1FlightDate;
  final String? via1AirportCode;
  final String? via1AirportName;
  final String? via1ClassType;
  final String? via1Class;
  final String? via2SEQ;
  final String? via2AirlineCode;
  final String? via2AirlineName;
  final String? via2FlightNumber;
  final String? via2FlightDate;
  final String? via2AirportCode;
  final String? via2AirportName;
  final String? via2ClassType;
  final String? via2Class;
  final String? printTime;
  final String? lastSTD;
  final String? via1STD;
  final String? via2STD;
  final String? pectabName;
  final String? firstCityName;
  final String? lastCityName;
  final String? via1CityName;
  final String? via2CityName;
  final String? extra1;
  final String? extra2;
  final String? extra3;
  final String? extra4;
  final String? extra5;
  final String? freeText;

  const ArtemisAcpsBagtag({
    this.tagNumber,
    this.sixDigitNumber,
    this.name,
    this.referenceNo,
    this.airlineThreeDigitCode,
    this.tagType,
    this.baggageCount,
    this.baggageWeight,
    this.weightUnit,
    this.limitType,
    this.agent,
    this.firstAirportCode,
    this.firstAirportName,
    this.lastSEQ,
    this.lastAirlineCode,
    this.lastAirlineName,
    this.lastFlightNumber,
    this.lastFlightDate,
    this.lastAirportCode,
    this.lastAirportName,
    this.lastClassType,
    this.lastClass,
    this.via1SEQ,
    this.via1AirlineCode,
    this.via1AirlineName,
    this.via1FlightNumber,
    this.via1FlightDate,
    this.via1AirportCode,
    this.via1AirportName,
    this.via1ClassType,
    this.via1Class,
    this.via2SEQ,
    this.via2AirlineCode,
    this.via2AirlineName,
    this.via2FlightNumber,
    this.via2FlightDate,
    this.via2AirportCode,
    this.via2AirportName,
    this.via2ClassType,
    this.via2Class,
    this.printTime,
    this.lastSTD,
    this.via1STD,
    this.via2STD,
    this.pectabName,
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

  factory ArtemisAcpsBagtag.fromJson(Map<String, dynamic> json) {
    return ArtemisAcpsBagtag(
      tagNumber: json['TagNumber'],
      sixDigitNumber: json['SixDigitNumber'],
      name: json['Name'],
      referenceNo: json['ReferenceNo'],
      airlineThreeDigitCode: json['AirlineThreeDigitCode'],
      tagType: json['TagType'],
      baggageCount: json['BaggageCount'],
      baggageWeight: json['BaggageWeight'],
      weightUnit: json['WeightUnit'],
      limitType: json['LimitType'],
      agent: json['Agent'],
      firstAirportCode: json['FirstAirportCode'],
      firstAirportName: json['FirstAirportName'],
      lastSEQ: json['LastSEQ'],
      lastAirlineCode: json['LastArilineCode'],
      lastAirlineName: json['LastAirlineName'],
      lastFlightNumber: json['LastFlightNumber'],
      lastFlightDate: json['LastFlightDate'],
      lastAirportCode: json['LastAirportCode'],
      lastAirportName: json['LastAirportName'],
      lastClassType: json['LastClassType'],
      lastClass: json['Lastclass'],
      via1SEQ: json['Via1SEQ'],
      via1AirlineCode: json['Via1ArilineCode'],
      via1AirlineName: json['Via1AirlineName'],
      via1FlightNumber: json['Via1FlightNumber'],
      via1FlightDate: json['Via1FlightDate'] ,
      via1AirportCode: json['Via1AirportCode'],
      via1AirportName: json['Via1AirportName'],
      via1ClassType: json['Via1ClassType'],
      via1Class: json['Via1Class'],
      via2SEQ: json['Via2SEQ'],
      via2AirlineCode: json['Via2ArilineCode'],
      via2AirlineName: json['Via2AirlineName'],
      via2FlightNumber: json['Via2FlightNumber'],
      via2FlightDate: json['Via2FlightDate'],
      via2AirportCode: json['Via2AirportCode'],
      via2AirportName: json['Via2AirportName'],
      via2ClassType: json['Via2ClassType'],
      via2Class: json['Via2Class'],
      printTime: json['PrintTime'],
      lastSTD: json['LastSTD'],
      via1STD: json['Via1STD'],
      via2STD: json['Via2STD'],
      pectabName: json['PectabName'],
      firstCityName: json['FirstCityName'],
      lastCityName: json['LastCityName'],
      via1CityName: json['Via1CityName'],
      via2CityName: json['Via2CityName'],
      extra1: json['Extra1'],
      extra2: json['Extra2'],
      extra3: json['Extra3'],
      extra4: json['Extra4'],
      extra5: json['Extra5'],
      freeText: json['FreeText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TagNumber': tagNumber,
      'SixDigitNumber': sixDigitNumber,
      'Name': name,
      'ReferenceNo': referenceNo,
      'AirlineThreeDigitCode': airlineThreeDigitCode,
      'TagType': tagType,
      'BaggageCount': baggageCount,
      'BaggageWeight': baggageWeight,
      'WeightUnit': weightUnit,
      'LimitType': limitType,
      'Agent': agent,
      'FirstAirportCode': firstAirportCode,
      'FirstAirportName': firstAirportName,
      'LastSEQ': lastSEQ,
      'LastArilineCode': lastAirlineCode,
      'LastAirlineName': lastAirlineName,
      'LastFlightNumber': lastFlightNumber,
      'LastFlightDate': lastFlightDate,
      'LastAirportCode': lastAirportCode,
      'LastAirportName': lastAirportName,
      'LastClassType': lastClassType,
      'Lastclass': lastClass,
      'Via1SEQ': via1SEQ,
      'Via1ArilineCode': via1AirlineCode,
      'Via1AirlineName': via1AirlineName,
      'Via1FlightNumber': via1FlightNumber,
      'Via1FlightDate': via1FlightDate,
      'Via1AirportCode': via1AirportCode,
      'Via1AirportName': via1AirportName,
      'Via1ClassType': via1ClassType,
      'Via1Class': via1Class,
      'Via2SEQ': via2SEQ,
      'Via2ArilineCode': via2AirlineCode,
      'Via2AirlineName': via2AirlineName,
      'Via2FlightNumber': via2FlightNumber,
      'Via2FlightDate': via2FlightDate,
      'Via2AirportCode': via2AirportCode,
      'Via2AirportName': via2AirportName,
      'Via2ClassType': via2ClassType,
      'Via2Class': via2Class,
      'PrintTime': printTime,
      'LastSTD': lastSTD,
      'Via1STD': via1STD,
      'Via2STD': via2STD,
      'PectabName': pectabName,
      'FirstCityName': firstCityName,
      'LastCityName': lastCityName,
      'Via1CityName': via1CityName,
      'Via2CityName': via2CityName,
      'Extra1': extra1,
      'Extra2': extra2,
      'Extra3': extra3,
      'Extra4': extra4,
      'Extra5': extra5,
      'FreeText': freeText,
    };
  }

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
    String? lastSEQ,
    String? lastArilineCode,
    String? lastAirlineName,
    String? lastFlightNumber,
    String? lastFlightDate,
    String? lastAirportCode,
    String? lastAirportName,
    String? lastClassType,
    String? lastclass,
    String? via1SEQ,
    String? via1ArilineCode,
    String? via1AirlineName,
    String? via1FlightNumber,
    String? via1FlightDate,
    String? via1AirportCode,
    String? via1AirportName,
    String? via1ClassType,
    String? via1Class,
    String? via2SEQ,
    String? via2ArilineCode,
    String? via2AirlineName,
    String? via2FlightNumber,
    String? via2FlightDate,
    String? via2AirportCode,
    String? via2AirportName,
    String? via2ClassType,
    String? via2Class,
    String? printTime,
    String? lastSTD,
    String? via1STD,
    String? via2STD,
    String? pectabName,
    String? firstCityName,
    String? lastCityName,
    String? via1CityName,
    String? via2CityName,
    String? extra1,
    String? extra2,
    String? extra3,
    String? extra4,
    String? extra5,
    String? freeText,
  }) {
    return ArtemisAcpsBagtag(
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
      lastSEQ: lastSEQ ?? this.lastSEQ,
      lastAirlineCode: lastArilineCode ?? this.lastAirlineCode,
      lastAirlineName: lastAirlineName ?? this.lastAirlineName,
      lastFlightNumber: lastFlightNumber ?? this.lastFlightNumber,
      lastFlightDate: lastFlightDate ?? this.lastFlightDate,
      lastAirportCode: lastAirportCode ?? this.lastAirportCode,
      lastAirportName: lastAirportName ?? this.lastAirportName,
      lastClassType: lastClassType ?? this.lastClassType,
      lastClass: lastclass ?? this.lastClass,
      via1SEQ: via1SEQ ?? this.via1SEQ,
      via1AirlineCode: via1ArilineCode ?? this.via1AirlineCode,
      via1AirlineName: via1AirlineName ?? this.via1AirlineName,
      via1FlightNumber: via1FlightNumber ?? this.via1FlightNumber,
      via1FlightDate: via1FlightDate ?? this.via1FlightDate,
      via1AirportCode: via1AirportCode ?? this.via1AirportCode,
      via1AirportName: via1AirportName ?? this.via1AirportName,
      via1ClassType: via1ClassType ?? this.via1ClassType,
      via1Class: via1Class ?? this.via1Class,
      via2SEQ: via2SEQ ?? this.via2SEQ,
      via2AirlineCode: via2ArilineCode ?? this.via2AirlineCode,
      via2AirlineName: via2AirlineName ?? this.via2AirlineName,
      via2FlightNumber: via2FlightNumber ?? this.via2FlightNumber,
      via2FlightDate: via2FlightDate ?? this.via2FlightDate,
      via2AirportCode: via2AirportCode ?? this.via2AirportCode,
      via2AirportName: via2AirportName ?? this.via2AirportName,
      via2ClassType: via2ClassType ?? this.via2ClassType,
      via2Class: via2Class ?? this.via2Class,
      printTime: printTime ?? this.printTime,
      lastSTD: lastSTD ?? this.lastSTD,
      via1STD: via1STD ?? this.via1STD,
      via2STD: via2STD ?? this.via2STD,
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
  }
}
