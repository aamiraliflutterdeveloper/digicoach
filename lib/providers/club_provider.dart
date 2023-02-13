import 'package:clients_digcoach/models/club.dart';
import 'package:clients_digcoach/repositories/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/enums/days_week.dart';
import '../models/day.dart';
import '../models/opening_hours.dart';

final clubProvider = ChangeNotifierProvider((ref) => ClubProvider());

class ClubProvider extends ChangeNotifier {
  final ClubRepository _clubRepository = ClubRepository();
  int _addClubCurrentTap = 0;
  int _clubManagerCurrentIndex = 0;
  List<Club> _clubs = [];
  bool _isLoading = false;
  String? _selectedClubId;
  List<OpeningHours> _openingHoursByClubId = [];

  /// getters
  List<Club> get clubs => _clubs;

  List<OpeningHours> get openingHoursByClubId => _openingHoursByClubId;

  String? get selectedClubId => _selectedClubId;

  int get coachManagerCurrentIndex => _clubManagerCurrentIndex;

  int get addClubCurrentTap => _addClubCurrentTap;

  bool get isLoading => _isLoading;

  /// setters
  void _loading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set selectedClubId(String? value) {
    _selectedClubId = value;
    notifyListeners();
  }

  set coachManagerCurrentIndex(int index) {
    _clubManagerCurrentIndex = index;
    notifyListeners();
  }

  set addClubCurrentTap(int index) {
    _addClubCurrentTap = index;
    notifyListeners();
  }

  Future<String?> getClubId() async {
    selectedClubId = await _clubRepository.getClubId();
    notifyListeners();
    return selectedClubId;
  }

  Future<void> removeClubById(String id) async {
    _loading(true);
    await _clubRepository.removeClubById(id);
    _loading(false);
  }

  Future<List<Club>> getClubs() async {
    _clubs = await _clubRepository.getClubs();
    notifyListeners();
    return _clubs;
  }

  Future<void> addClub(Club club) async {
    _clubRepository.addClub(club);
    notifyListeners();
  }

  Future<void> getOpeningHoursByClubId() async {
    _loading(true);
    _openingHoursByClubId =
        await _clubRepository.getOpeningHoursByClubId(_selectedClubId!);

    _loading(false);
  }
}
