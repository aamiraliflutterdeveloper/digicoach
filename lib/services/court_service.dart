import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/court.dart';
import '../repositories/court_repository.dart';

final courtServiceProvider = ChangeNotifierProvider((ref) => CourtService());

class CourtService extends ChangeNotifier {
  final courtRepository = CourtRepository();

  int _selectedCourtIndex = 0;

  int get selectedCourtIndex => _selectedCourtIndex;

  set setSelectedCourtIndex(int value) {
    _selectedCourtIndex = value;
    notifyListeners();
  }

  List<Court> _courts = [];

  List<Court> get courts => _courts;

  set setCourts(List<Court> value) {
    _courts = value;
    notifyListeners();
  }

  Future<List<Court>> getCourtsByClubId(String clubId) async {
    final response = await courtRepository.getCourtsByClubId(clubId);

    setCourts = response;

    return response;
  }
}
