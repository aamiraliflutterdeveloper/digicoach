import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/coach_repository.dart';
import '../models/coach.dart';

final coachProvider = ChangeNotifierProvider((ref) => CoachProvider());

class CoachProvider extends ChangeNotifier {
  final CoachRepository _coachRepository = CoachRepository();

  String? _selectedCoachId;

  List<Coach> _coaches = [];
  List<Coach> _coachesByClubId = [];

  List<Coach> get coaches => _coaches;

  List<Coach> get coachesByClubId => _coachesByClubId;

  String? get selectedCoachId => _selectedCoachId;


  bool _isLoading = false;

  /// getters

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



  // Future<String?> getCoachId() async {
  //   _selectedCoachId = await _coachRepository.getCoachId();
  //   notifyListeners();
  //   return _selectedCoachId;
  // }

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
