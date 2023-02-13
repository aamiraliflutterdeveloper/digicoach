// An appointment model class for tennis court bookings and reservations
import 'package:clients_digcoach/core/enums/reservation_status.dart';
import 'package:clients_digcoach/models/coach.dart';

class Reservation {
  final String id;
  final String? courtId;
  final int courtNumber;
  final String clubId;
  final String coachId;
  final DateTime startTime;
  final DateTime endTime;
  final ReservationStatus? status;
  final String title;

  const Reservation({
    required this.id,
    this.courtId,
    required this.clubId,
    required this.startTime,
    required this.endTime,
     this.status,
    required this.title,
    required this.coachId,
    required this.courtNumber,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json['id'],
        courtId: json['courtId'],
        clubId: json['clubId'],
        startTime: DateTime.parse(json['startTime']),
        endTime: DateTime.parse(json['endTime']),
        status: ReservationStatus.fromString(json['status']),
        title: json['title'],
        coachId: json['coachId'],
        courtNumber: json['courtNumber'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'courtId': courtId,
        'clubId': clubId,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'status': status.toString(),
        'title': title,
        'coachId': coachId,
        'courtNumber': courtNumber,
      };
}
