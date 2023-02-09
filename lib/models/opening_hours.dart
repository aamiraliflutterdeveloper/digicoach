class OpeningHours {
  final String id;
  final String dayId;
  final DateTime from;
  final DateTime to;

  const OpeningHours({
    required this.id,
    required this.dayId,
    required this.from,
    required this.to,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        id: json['id'],
        dayId: json['dayId'],
        from: json['from'],
        to: json['to'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'dayId': dayId,
        'from': from,
        'to': to,
      };
}
