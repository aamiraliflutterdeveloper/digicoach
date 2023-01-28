import 'package:clients_digcoach/models/club.dart';
import 'package:clients_digcoach/repositories/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clubServiceProvider = ChangeNotifierProvider((ref) => ClubService());

class ClubService extends ChangeNotifier {
  final ClubRepository _clubRepository = ClubRepository();

  int _selectedClubIndex = 0;

  List<Club> _clubs = [];

  List<Club> get clubs => _clubs;

  int get selectedClubIndex => _selectedClubIndex;

  set setClubs(List<Club> value) {
    _clubs = value;
    notifyListeners();
  }

  set setSelectedClubIndex(int value) {
    _selectedClubIndex = value;
    notifyListeners();
  }

  Future<List<Club>> getClubs() async {
    final response = await _clubRepository.getClubs();

    setClubs = response;

    return response;
  }
}
