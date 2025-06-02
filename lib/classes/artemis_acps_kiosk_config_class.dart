class ArtemisAcpsKioskConfig {
  final String deviceId;
  final String? kioskId;
  final String isDcs;
  final String airportToken;
  final String baseUrl;

  ArtemisAcpsKioskConfig({
    required this.deviceId,
    required this.kioskId,
    required this.isDcs,
    required this.airportToken,
    required this.baseUrl,
  });

  ArtemisAcpsKioskConfig copyWith({
    String? deviceId,
    String? kioskId,
    String? isDcs,
    String? airportToken,
    String? baseUrl,
  }) =>
      ArtemisAcpsKioskConfig(
        deviceId: deviceId ?? this.deviceId,
        kioskId: kioskId ?? this.kioskId,
        isDcs: isDcs ?? this.isDcs,
        airportToken: airportToken ?? this.airportToken,
        baseUrl: baseUrl ?? this.baseUrl,
      );

  factory ArtemisAcpsKioskConfig.fromJson(Map<String, dynamic> json) => ArtemisAcpsKioskConfig(
    deviceId: json["DeviceID"],
    kioskId: json["KioskID"],
    isDcs: json["IsDcs"],
    baseUrl: json["BaseUrl"],
    airportToken: json["AirportToken"],
  );

  factory ArtemisAcpsKioskConfig.fromBarcode(String barcode) => ArtemisAcpsKioskConfig(
    deviceId: barcode.split("|")[2],
    isDcs: barcode.split("|")[3],
    baseUrl: barcode.split("|")[4],
    airportToken: barcode.split("|")[5],
    kioskId: barcode.split("|").length<5?null:barcode.split("|")[6],
  );

  Map<String, dynamic> toJson() => {
    "DeviceID": deviceId,
    "IsDcs": isDcs,
    "BaseUrl": baseUrl,
    "AirportToken": airportToken,
    "KioskID": kioskId,
  };

  String? get deviceName =>kioskId?.split("-").last;
  String get toBarcode =>deviceName==null? 'bdcsprinterqr|kiosk|$deviceId|$isDcs|$baseUrl|$airportToken|': 'bdcsprinterqr|kiosk|$deviceId|$isDcs|$baseUrl|$airportToken|$deviceName|';
  String get getStationQR =>'bdcsprinterqr|kiosk|$deviceId|$isDcs|$baseUrl|$airportToken|';


}