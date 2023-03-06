import 'package:clients_digcoach/models/club/club.dart';
import 'package:clients_digcoach/models/club/manager.dart';
import 'package:clients_digcoach/repositories/club_repository.dart';
import 'package:clients_digcoach/repositories/manager_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clubProvider = ChangeNotifierProvider((ref) => ClubProvider());

class ClubProvider extends ChangeNotifier {
  final _clubRepository = ClubRepository();
  final _managerRepository = ManagerRepository();

  List<Club> _clubs = [];
  List<Club> get clubs => _clubs;

  List<Manager> _managers = [];
  List<Manager> get managers => _managers;

  String? _selectedClubId;
  String? get selectedClubId => _selectedClubId;

  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _loading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set selectedClubId(String? value) {
    _selectedClubId = value;
    notifyListeners();
  }

  set tabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }

  Future<Club> getClub() async {
    final club = await _clubRepository.getClub();
    selectedClubId = club.id;
    notifyListeners();
    return club;
  }

  Future<void> removeClubById(String id) async {
    if (id == clubs.first.id) return;

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
    final clubIds = _clubs.map((club) => club.id).toList();
    final isEditing = clubIds.contains(club.id);

    if (isEditing) {
      final index = _clubs.indexWhere((oldClub) => oldClub.id == club.id);
      final newClubs = List.of(_clubs);
      newClubs[index] = club;

      _clubs = newClubs;
      notifyListeners();
    } else {
      _clubs.add(club);
      notifyListeners();
    }

    //_clubRepository.addClub(club);
    notifyListeners();
  }

  Future<void> removeManagerById(String id) async {
    if (id == managers.first.id) return;

    _loading(true);
    await _managerRepository.removeManagerById(id);
    _loading(false);
  }

  Future<List<Manager>> getManagers() async {
    _managers = await _managerRepository.getManagers();
    notifyListeners();
    return _managers;
  }

  Future<void> addManager(Manager manager) async {
    _managerRepository.addManager(manager);
    notifyListeners();
  }
}
