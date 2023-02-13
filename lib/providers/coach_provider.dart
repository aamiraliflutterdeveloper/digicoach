import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/coach_repository.dart';
import '../models/coach.dart';

final coachProvider = ChangeNotifierProvider((ref) => CoachProvider());

class CoachProvider extends ChangeNotifier {
  final CoachRepository _coachRepository = CoachRepository();

  int _coachesViewIndex = 0;
  int _coachManagerCurrentIndex = 0;
  String? _selectedCoachId;

  List<Coach> _coaches = [];
  List<Coach> _coachesByClubId = [];

  bool _isLoading = false;

  /// getters
  List<Coach> get coaches => _coaches;

  List<Coach> get coachesByClubId => _coachesByClubId;

  String? get selectedCoachId => _selectedCoachId;

  bool get isLoading => _isLoading;
  int get coachesViewIndex => _coachesViewIndex;
  int get coachManagerCurrentIndex => _coachManagerCurrentIndex;

  /// setters
  void _loading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set selectedCoachId(String? value) {
    _selectedCoachId = value;
    notifyListeners();
  }

  set coachesViewIndex(int value) {
    _coachesViewIndex = value;
    notifyListeners();
  }

  set coachManagerCurrentIndex(int value) {
    _coachManagerCurrentIndex = value;
    notifyListeners();
  }

  /// methods

  Future<String?> getCoachId(String id) async {
    selectedCoachId = await _coachRepository.getCoachId(id);
    notifyListeners();
    return selectedCoachId;
  }

  Future<List<Coach>> getCoaches() async {
    _coaches = await _coachRepository.getCoaches();
    notifyListeners();
    return _coaches;
  }

  Future<List<Coach>> getCoachesByClubId(String id) async {
    _loading(true);
    _coachesByClubId = await _coachRepository.getCoachesByClubId(id);
    _loading(false);
    notifyListeners();
    return _coachesByClubId;
  }
}
