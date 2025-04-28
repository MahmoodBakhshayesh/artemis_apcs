class ArtemisAcpsKioskStatus {
  final bool isOnline;
  final bool hasBp;
  final bool hasBt;
  final String message;

  ArtemisAcpsKioskStatus({
    required this.isOnline,
    required this.hasBp,
    required this.hasBt,
    required this.message,
  });

  ArtemisAcpsKioskStatus copyWith({
    bool? isOnline,
    bool? hasBp,
    bool? hasBt,
    String? message,
  }) =>
      ArtemisAcpsKioskStatus(
        isOnline: isOnline ?? this.isOnline,
        hasBp: hasBp ?? this.hasBp,
        hasBt: hasBt ?? this.hasBt,
        message: message ?? this.message,
      );

  factory ArtemisAcpsKioskStatus.fromJson(Map<String, dynamic> json) => ArtemisAcpsKioskStatus(
    isOnline: json["isOnline"],
    hasBp: json["hasBP"],
    hasBt: json["hasBT"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "isOnline": isOnline,
    "hasBP": hasBp,
    "hasBT": hasBt,
    "message": message,
  };
}