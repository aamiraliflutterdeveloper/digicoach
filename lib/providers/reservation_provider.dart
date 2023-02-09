import 'package:clients_digcoach/repositories/reservation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/reservation.dart';

final reservationProvider =
    ChangeNotifierProvider((ref) => ReservationProvider());

class ReservationProvider extends ChangeNotifier {
  final _reservationRepository = ReservationRepository();

  /// variables
  List<Reservation> _reservations = [];
  // List<Reservation> _reservationsByCourtId = [];
  List<Reservation> _reservationsByCourtNumber = [];
  List<Reservation> _reservationsByClubId = [];
  bool _isLoading = false;

  /// getters
  // List<Reservation> get reservationsByCourtId => _reservationsByCourtId;
  List<Reservation> get reservationsByCourtNumber => _reservationsByCourtNumber;

  List<Reservation> get reservations => _reservations;

  List<Reservation> get reservationsByClubId => _reservationsByClubId;

  bool get isLoading => _isLoading;

  /// setters
  void _loading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  // set reservationsByCourtId(List<Reservation> reservations) {
  //   _reservationsByCourtId = reservations;
  //   notifyListeners();
  // }
  set reservationsByCourtNumber(List<Reservation> reservations) {
    _reservationsByCourtNumber = reservations;
    notifyListeners();
  }

  /// methods
  Future<List<Reservation>> getReservations() async {
    _reservations = await _reservationRepository.getReservations();
    notifyListeners();
    return _reservations;
  }

  Future<List<Reservation>> getReservationsByClubId(String id) async {
    _loading(true);
    _reservationsByClubId =
        await _reservationRepository.getReservationsByClubId(id);
    _loading(false);
    notifyListeners();
    return _reservationsByClubId;
  }

  // Future<List<Reservation>> getReservationsByCourtId(String id) async {
  //   _loading(true);
  //   reservationsByCourtId =
  //       await _reservationRepository.getReservationsByCourtId(id);
  //   _loading(false);
  //   return reservationsByCourtId;
  // }
  Future<List<Reservation>> getReservationsByCourtNumber(int courtNumber) async {
    _loading(true);

    // reservationsByCourtId =
    reservationsByCourtNumber =
        await _reservationRepository.getReservationsByCourtNumber(courtNumber);
    _loading(false);
    // return reservationsByCourtId;
    return reservationsByCourtNumber;
  }

  void addReservation(Reservation reservation,String clubId,
      // String courtId
      int courtNumber
      ) {
    _reservationRepository.addReservation(reservation);
    getReservationsByClubId(clubId);
    getReservationsByCourtNumber(courtNumber);
    // getReservationsByCourtId(courtId);
    notifyListeners();
  }
}
