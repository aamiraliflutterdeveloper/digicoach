import 'package:clients_digcoach/data/reservations.dart';

import '../models/reservation.dart';

class ReservationRepository {
  Future<List<Reservation>> getReservations() async => Future.delayed(
        const Duration(milliseconds: 100),
        () => reservations,
      );

  void addReservation(Reservation reservation) => reservations.add(reservation);

  Future<List<Reservation>> getReservationsByClubId(String id) async {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => reservations.where((element) => element.clubId == id).toList(),
    );
  }

  Future<List<Reservation>> getReservationsByCoachId({
    required String coachId,
  }) async {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () =>
          reservations.where((element) => element.coachId == coachId).toList(),
    );
  }

  Future<List<Reservation>> getReservationsByCourtId(String id) async {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => reservations.where((element) => element.courtId == id).toList(),
    );
  }

  Future<List<Reservation>> getReservationsByCourtNumber(
      int courtNumber) async {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => reservations
          .where((element) => element.courtNumber == courtNumber)
          .toList(),
    );
  }
}
