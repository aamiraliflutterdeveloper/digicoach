import 'package:clients_digcoach/models/club.dart';
import 'package:clients_digcoach/repositories/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clubProvider = ChangeNotifierProvider((ref) => ClubProvider());

class ClubProvider extends ChangeNotifier {
  final ClubRepository _clubRepository = ClubRepository();
  int _addClubCurrentTap = 0;
  int _currentIndex = 0;
  List<Club> _clubs = [];
  bool _isLoading = false;
  String? _selectedClubId;

  /// getters
  List<Club> get clubs => _clubs;

  String? get selectedClubId => _selectedClubId;

  int get currentIndex => _currentIndex;
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


  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
 set addClubCurrentTap(int index) {
    _addClubCurrentTap = index;
    notifyListeners();
  }


  // Future<String?> getClubId() async {
  //   _selectedClubId = await _clubRepository.getClubId();
  //   notifyListeners();
  //   return _selectedClubId;
  // }
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
}
