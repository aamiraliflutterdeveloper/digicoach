// An appointment model class for tennis court bookings and reservations
import 'package:clients_digcoach/core/enums.dart';

class Reservation {
  final String id;
  final String courtId;
  final String clubId;
  final DateTime startTime;
  final DateTime endTime;
  final ReservationStatus status;
  final String title;
  final String coachId;

  Reservation({
   required this.id,
   required this.courtId,
   required this.clubId,
   required this.startTime,
   required this.endTime,
   required this.status,
   required this.title,
   required this.coachId,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      courtId: json['courtId'],
      clubId: json['clubId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      status: ReservationStatus.values[json['status']],
      title: json['title'],
      coachId: json['coachId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courtId': courtId,
      'clubId': clubId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'status': status.index,
      'title': title,
      'coachId': coachId,
    };
  }
}
