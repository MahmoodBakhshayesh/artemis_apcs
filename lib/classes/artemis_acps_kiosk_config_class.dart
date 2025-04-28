class ArtemisAcpsKioskConfig {
  final String deviceId;
  final String isDcs;
  final String airportToken;
  final String baseUrl;
  final String? deviceName;

  ArtemisAcpsKioskConfig({
    required this.deviceId,
    required this.isDcs,
    required this.airportToken,
    required this.baseUrl,
    required this.deviceName,
  });

  ArtemisAcpsKioskConfig copyWith({
    String? deviceId,
    String? isDcs,
    String? airportToken,
    String? baseUrl,
    String? deviceName,
  }) =>
      ArtemisAcpsKioskConfig(
        deviceId: deviceId ?? this.deviceId,
        isDcs: isDcs ?? this.isDcs,
        airportToken: airportToken ?? this.airportToken,
        baseUrl: baseUrl ?? this.baseUrl,
        deviceName: deviceName ?? this.deviceName,
      );

  factory ArtemisAcpsKioskConfig.fromJson(Map<String, dynamic> json) => ArtemisAcpsKioskConfig(
    deviceId: json["DeviceID"],
    isDcs: json["IsDcs"],
    baseUrl: json["BaseUrl"],
    airportToken: json["AirportToken"],
    deviceName: json["DeviceName"],
  );

  factory ArtemisAcpsKioskConfig.fromBarcode(String barcode) => ArtemisAcpsKioskConfig(
    deviceId: barcode.split("|")[2],
    isDcs: barcode.split("|")[3],
    baseUrl: barcode.split("|")[4],
    airportToken: barcode.split("|")[5],
    deviceName: barcode.split("|").length<5?null:barcode.split("|")[6],
  );

  Map<String, dynamic> toJson() => {
    "DeviceID": deviceId,
    "IsDcs": isDcs,
    "BaseUrl": baseUrl,
    "AirportToken": airportToken,
    "DeviceName": deviceName,
  };

  String get toBarcode =>deviceName==null? 'bdcsprinterqr|kiosk|$deviceId|$isDcs|$baseUrl|$airportToken|': 'bdcsprinterqr|kiosk|$deviceId|$isDcs|$baseUrl|$airportToken|$deviceName|';
  String get getStationQR =>'bdcsprinterqr|kiosk|$deviceId|$isDcs|$baseUrl|$airportToken|';

}