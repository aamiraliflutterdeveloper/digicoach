import '../core/enums/reservation_status.dart';
import '../models/reservation.dart';

List<Reservation> reservations = [
  Reservation(
    id: '1',
    courtId: '1',
    clubId: '1',
    coachId: '1',
    startTime: DateTime.now().add(const Duration(days: 1)),
    endTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 1,
  ),
  Reservation(
    id: '2',
    courtId: '2',
    clubId: '1',
    coachId: '1',
    startTime: DateTime.now().add(const Duration(days: 2)),
    endTime: DateTime.now().add(const Duration(days: 2, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 2,
  ),
  Reservation(
    id: '3',
    courtId: '3',
    clubId: '1',
    coachId: '2',
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 3,
  ),
  Reservation(
    id: '4',
    courtId: '4',
    clubId: '1',
    coachId: '2',
    startTime: DateTime.now().add(const Duration(days: 1)),
    endTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 4,
  ),
  Reservation(
    id: '5',
    courtId: '5',
    clubId: '1',
    coachId: '3',
    startTime: DateTime.now().add(const Duration(days: 1)),
    endTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 5,
  ),
  Reservation(
    id: '6',
    courtId: '6',
    clubId: '2',
    coachId: '4',
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 1,
  ),
  Reservation(
    id: '7',
    courtId: '7',
    clubId: '2',
    coachId: '4',
    startTime: DateTime.now().add(const Duration(days: 1)),
    endTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 2,
  ),
  Reservation(
    id: '8',
    courtId: '8',
    clubId: '2',
    coachId: '5',
    startTime: DateTime.now().add(const Duration(days: 2)),
    endTime: DateTime.now().add(const Duration(days: 2, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 3,
  ),
  Reservation(
    id: '9',
    courtId: '9',
    clubId: '2',
    coachId: '1',
    startTime: DateTime.now().add(const Duration(days: 2)),
    endTime: DateTime.now().add(const Duration(days: 2, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 4,
  ),
  Reservation(
    id: '10',
    courtId: '10',
    clubId: '2',
    coachId: '3',
    startTime: DateTime.now().add(const Duration(days: 3)),
    endTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 5,
  ),
  Reservation(
    id: '11',
    courtId: '1',
    clubId: '1',
    coachId: '2',
    startTime: DateTime.now().add(const Duration(days: 3)),
    endTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 6,
  ),
  Reservation(
    id: '12',
    courtId: '2',
    clubId: '1',
    coachId: '4',
    startTime: DateTime.now().add(const Duration(days: 3)),
    endTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 7,
  ),
  Reservation(
    id: '13',
    courtId: '3',
    clubId: '1',
    coachId: '5',
    startTime: DateTime.now().add(const Duration(days: 3)),
    endTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 8,
  ),
  Reservation(
    id: '14',
    courtId: '4',
    clubId: '1',
    coachId: '1',
    startTime: DateTime.now().add(const Duration(days: 3)),
    endTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 9,
  ),
  Reservation(
    id: '15',
    courtId: '5',
    clubId: '2',
    coachId: '3',
    startTime: DateTime.now().add(const Duration(days: 3)),
    endTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 6,
  ),
  Reservation(
    id: '16',
    courtId: '6',
    clubId: '2',
    coachId: '4',
    startTime: DateTime.now().add(const Duration(days: 3)),
    endTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 7,
  ),
  Reservation(
    id: '17',
    courtId: '7',
    clubId: '2',
    coachId: '3',
    startTime: DateTime.now().add(const Duration(days: 3)),
    endTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 8,
  ),
  Reservation(
    id: '18',
    courtId: '1',
    clubId: '1',
    coachId: '2',
    startTime: DateTime.now().add(const Duration(days: 3)),
    endTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
    status: ReservationStatus.pending,
    title: 'Tennis Lesson',
    courtNumber: 10,
  ),
];

class ReservationRepository {
  // Future<Reservation> getReservation(String id) async {
  //   return Future.delayed(
  //     const Duration(seconds: 1),
  //     () => reservations.firstWhere((reservation) => reservation.id == id),
  //   );
  // }

  Future<List<Reservation>> getReservations() async => Future.delayed(
        const Duration(seconds: 1),
        () => reservations,
      );

  void addReservation(Reservation reservation) => reservations.add(reservation);

  Future<List<Reservation>> getReservationsByClubId(String id) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => reservations.where((element) => element.clubId == id).toList(),
    );
  }

  Future<List<Reservation>> getReservationsByCourtId(String id) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => reservations.where((element) => element.courtId == id).toList(),
    );
  }
  Future<List<Reservation>> getReservationsByCourtNumber(int courtNumber) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => reservations.where((element) => element.courtNumber == courtNumber).toList(),
    );
  }
}
