import 'package:clients_digcoach/repositories/reservation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/reservation.dart';

final reservationProvider =
    ChangeNotifierProvider((ref) => ReservationService());

class ReservationService extends ChangeNotifier {
  final _reservationRepository = ReservationRepository();

  String _selectedCourt = '1';

  String get selectedCourt => _selectedCourt;

  set setSelectedCourt(String value) {
    _selectedCourt = value;
    notifyListeners();
  }

  List<Reservation> _reservations = [];

  List<Reservation> get reservations => _reservations;

  set setReservations(List<Reservation> value) {
    _reservations = value;
    notifyListeners();
  }

  Future<List<Reservation>> getReservations() async {
    final response = await _reservationRepository.getReservations();

    setReservations = response;

    return response;
  }
}
