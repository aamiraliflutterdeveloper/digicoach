import 'package:clients_digcoach/models/days.dart';

import 'opening_time.dart';

class OpeningHours {
  final Days day;
  final List<OpeningTime> times;

  const OpeningHours({
    required this.day,
    required this.times,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        day: Days.fromString(json['day']),
        times: json['times'] != null
            ? (json['times'] as List)
                .map((time) => OpeningTime.fromJson(time))
                .toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        'day': day.toString(),
        'times': times.map((time) => time.toJson()).toList(),
      };

  OpeningHours copy({
    final Days? day,
    final List<OpeningTime>? times,
  }) =>
      OpeningHours(
        day: day ?? this.day,
        times: times ?? this.times,
      );
}
