import 'package:clients_digcoach/models/club/amenity.dart';
import 'package:clients_digcoach/models/club/general_info.dart';
import 'package:clients_digcoach/models/reservation.dart';

import '../coach.dart';
import '../court.dart';
import 'opening_hours.dart';
import 'holiday.dart';

class Club {
  final String id;
  final GeneralInfo generalInfo;
  final List<Court> courts;
  final List<Coach> coaches;
  final List<Reservation> reservations;
  final List<OpeningHours> openingHours;
  final List<Holiday> holidays;
  final List<Amenity> amenities;

  const Club({
    required this.id,
    required this.generalInfo,
    required this.courts,
    required this.coaches,
    required this.reservations,
    required this.openingHours,
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
        openingHours: json['openingHours'] != null
            ? (json['openingHours'] as List)
                .map((e) => OpeningHours.fromJson(e))
                .toList()
            : [],
        holidays: json['holidays'] != null
            ? (json['holidays'] as List)
                .map((e) => Holiday.fromJson(e))
                .toList()
            : [],
        amenities: json['amenities'] != null
            ? (json['amenities'] as List<Amenity>).map((e) => e).toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'generalInfo': generalInfo.toJson(),
        'courts': courts.map((e) => e.toJson()).toList(),
        'coaches': coaches.map((e) => e.toJson()).toList(),
        'openingHours': openingHours.map((e) => e.toJson()).toList(),
        'holidays': holidays.map((e) => e.toJson()).toList(),
        'amenities': amenities.map((e) => e).toList(),
      };

  Club copyWith({
    final String? id,
    final GeneralInfo? generalInfo,
    final List<Court>? courts,
    final List<Coach>? coaches,
    final List<Reservation>? reservations,
    final List<OpeningHours>? openingHours,
    final List<Holiday>? holidays,
    final List<Amenity>? amenities,
  }) =>
      Club(
        id: id ?? this.id,
        generalInfo: generalInfo ?? this.generalInfo,
        courts: courts ?? this.courts,
        coaches: coaches ?? this.coaches,
        reservations: reservations ?? this.reservations,
        openingHours: openingHours ?? this.openingHours,
        holidays: holidays ?? this.holidays,
        amenities: amenities ?? this.amenities,
      );
}
