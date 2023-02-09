import 'package:clients_digcoach/core/enums/days_week.dart';

import 'opening_hours.dart';

class Day {
  final String id;
  final String clubId;
  final DaysWeek daysWeek;
  final bool checked;
  final List<OpeningHours> openingHours;

 const Day({
    required this.id,
    required this.daysWeek,
    required this.checked,
    required this.openingHours,
    required this.clubId,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        id: json['id'],
        clubId: json['clubId'],
    daysWeek:DaysWeek.fromString(json['name']) ,
        checked: json['checked'],
        openingHours: json['openingHours'] != null
            ? (json['openingHours'] as List)
                .map((e) => OpeningHours.fromJson(e))
                .toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clubId': clubId,
        'daysWeek': daysWeek.toString(),
        'checked': checked,
        'openingHours': openingHours.map((e) => e.toJson()).toList(),
      };
}
