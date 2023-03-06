import 'package:clients_digcoach/data/clubs.dart';
import 'package:clients_digcoach/data/opening_hours.dart';
import '../models/club/opening_time.dart';
import '../models/club/club.dart';

class ClubRepository {
  Future<Club> getClub() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return clubs.first;
  }

  Future<void> removeClubById(String id) async {
    await Future.delayed(const Duration(microseconds: 100));

    clubs.removeWhere((club) => club.id == id);
  }

  Future<void> addClub(Club club) async {
    await Future.delayed(const Duration(microseconds: 100));
    clubs.add(club);
  }

  Future<List<Club>> getClubs() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return clubs;
  }
}
