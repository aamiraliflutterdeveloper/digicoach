// Club model for tennis club
import 'package:clients_digcoach/models/general_info.dart';
import 'package:clients_digcoach/models/reservation.dart';

import 'coach.dart';
import 'court.dart';
import 'day.dart';
import 'holiday.dart';

class Club {
  final String id;
  final GeneralInfo generalInfo;
  final List<Court> courts;
  final List<Coach> coaches;
  final List<Reservation> reservations;
  final List<Day> days;
  final List<Holiday> holidays;
  final List<String> amenities;

  const Club({
    required this.id,
    required this.generalInfo,
    required this.courts,
    required this.coaches,
    required this.reservations,
    required this.days,
    required this.holidays,
    required this.amenities,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json['id'],
        generalInfo: GeneralInfo.fromJson(json['generalInfo']),
        courts: json['courts'] != null
            ? (json['courts'] as List).map((e) => Court.fromJson(e)).toList()
            : [],
        coaches: json['coaches'] != null
            ? (json['coaches'] as List).map((e) => Coach.fromJson(e)).toList()
            : [],
        reservations: json['reservations'] != null
            ? (json['reservations'] as List)
                .map((e) => Reservation.fromJson(e))
                .toList()
            : [],
        days: json['days'] != null
            ? (json['days'] as List).map((e) => Day.fromJson(e)).toList()
            : [],
        holidays: json['holidays'] != null
            ? (json['holidays'] as List)
                .map((e) => Holiday.fromJson(e))
                .toList()
            : [],
        amenities: json['amenities'] != null
            ? (json['amenities'] as List<String>).map((e) => e).toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'generalInfo': generalInfo.toJson(),
        'courts': courts.map((e) => e.toJson()).toList(),
        'coaches': coaches.map((e) => e.toJson()).toList(),
        'days': days.map((e) => e.toJson()).toList(),
        'holidays': holidays.map((e) => e.toJson()).toList(),
        'amenities': amenities.map((e) => e).toList(),
      };
}
