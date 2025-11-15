
class ArtemisKioskSettingRow {
  final int id;
  final int kioskId;
  final String key;
  final String value;
  final bool isActive;

  ArtemisKioskSettingRow({
    required this.id,
    required this.kioskId,
    required this.key,
    required this.value,
    required this.isActive,
  });

  ArtemisKioskSettingRow copyWith({
    int? id,
    int? kioskId,
    String? key,
    String? value,
    bool? isActive,
  }) =>
      ArtemisKioskSettingRow(
        id: id ?? this.id,
        kioskId: kioskId ?? this.kioskId,
        key: key ?? this.key,
        value: value ?? this.value,
        isActive: isActive ?? this.isActive,
      );

  factory ArtemisKioskSettingRow.fromJson(Map<String, dynamic> json) => ArtemisKioskSettingRow(
    id: json["id"],
    kioskId: json["kioskId"],
    key: json["key"],
    value: json["value"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kioskId": kioskId,
    "key": key,
    "value": value,
    "isActive": isActive,
  };
}
