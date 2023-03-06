import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/coach_repository.dart';
import '../models/coach.dart';

final coachProvider = ChangeNotifierProvider((ref) => CoachProvider());

class CoachProvider extends ChangeNotifier {
  final _coachRepository = CoachRepository();

  int _coachesViewIndex = 0;
  int get coachesViewIndex => _coachesViewIndex;

  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  String? _selectedCoachId;
  String? get selectedCoachId => _selectedCoachId;

  List<Coach> _coaches = [];
  List<Coach> get coaches => _coaches;

  List<Coach> _coachesByClubId = [];
  List<Coach> get coachesByClubId => _coachesByClubId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

  set tabIndex(int value) {
    _tabIndex = value;
    notifyListeners();
  }

  Future<void> removeCoachById(String id) async {
    if (id == coaches.first.id) return;

    _loading(true);
    _coaches = List.of(_coaches)..removeWhere((coach) => coach.id == id);
    await _coachRepository.removeCoachById(id);
    _loading(false);
    notifyListeners();
  }

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
