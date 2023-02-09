import 'package:clients_digcoach/providers/reservation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/court.dart';
import '../repositories/court_repository.dart';

final courtProvider = ChangeNotifierProvider((ref) => CourtProvider());

class CourtProvider extends ChangeNotifier {
  final courtRepository = CourtRepository();
  final calendarController = CalendarController();

  String ?_selectedCourtNumber;

  // String ?_selectedCourtId;

  // String? get selectedCourtId => _selectedCourtId;
  String? get selectedCourtNumber => _selectedCourtNumber;

  set selectedCourtNumber(String ?value) {
    _selectedCourtNumber = value;
    notifyListeners();
  }
  // set selectedCourtId(String ?value) {
  //   _selectedCourtId = value;
  //   notifyListeners();
  // }

  List<Court> _courts = [];

  List<Court> get courts => _courts;

  Future<List<Court>> getCourts() async {
    _courts = await courtRepository.getCourts();
    notifyListeners();
    return _courts;
  }
 List<Court> _courtsByClubId = [];

  List<Court> get courtsByClubId => _courtsByClubId;

  Future<List<Court>> getCourtsByClubId(String clubId,WidgetRef ref) async {
    _courtsByClubId = await courtRepository.getCourtsByClubId(clubId);
    ref.read(reservationProvider).reservationsByCourtNumber  = [];
    // ref.read(reservationProvider).reservationsByCourtId  = [];
    // ref.read(courtProvider).selectedCourtId = null;
    ref.read(courtProvider).selectedCourtNumber = null;
    notifyListeners();
    return _courtsByClubId;
  }

  // Future<String?> getCourtId() async {
  //   _selectedCourtId = await courtRepository.getCourtId();
  //   notifyListeners();
  //   return _selectedCourtId;
  // }
}
