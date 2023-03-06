import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/court.dart';
import '../repositories/court_repository.dart';

final courtProvider = ChangeNotifierProvider((ref) => CourtProvider());

class CourtProvider extends ChangeNotifier {
  final courtRepository = CourtRepository();
  int _courtsViewIndex = 0;

  int? _selectedCourtNumber;
  List<Court> _courtsByClubId = [];
  List<Court> _courts = [];

  /// getters

  int? get selectedCourtNumber => _selectedCourtNumber;

  List<Court> get courtsByClubId => _courtsByClubId;

  List<Court> get courts => _courts;

  int get courtsViewIndex => _courtsViewIndex;

  /// setters

  set courtsViewIndex(int value) {
    _courtsViewIndex = value;
    notifyListeners();
  }

  set selectedCourtNumber(int? value) {
    _selectedCourtNumber = value;
    notifyListeners();
  }

  /// methods
  Future<List<Court>> getCourts() async {
    _courts = await courtRepository.getCourts();
    notifyListeners();
    return _courts;
  }

  Future<List<Court>> getCourtsByClubId(String clubId, WidgetRef ref) async {
    _courtsByClubId = await courtRepository.getCourtsByClubId(clubId);
    notifyListeners();
    return _courtsByClubId;
  }

  Future<int?> getCourtNumber(String clubId) async {
    selectedCourtNumber = (await courtRepository.getCourtNumber(clubId));
    notifyListeners();
    return selectedCourtNumber;
  }
}
