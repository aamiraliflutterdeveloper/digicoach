import 'package:clients_digcoach/core/enums/days_week.dart';

class OpeningHours {
  final String id;
  final String clubId;
  final DaysWeek daysWeek;
  final DateTime from;
  final DateTime to;

  const OpeningHours({
    required this.id,
    required this.daysWeek,
    required this.from,
    required this.to,required this.clubId,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        id: json['id'],
        clubId: json['clubId'],
        daysWeek: DaysWeek.fromString(json['daysWeek']),
        from: json['from'],
        to: json['to'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clubId': clubId,
        'daysWeek': daysWeek.toString(),
        'from': from,
        'to': to,
      };
}
