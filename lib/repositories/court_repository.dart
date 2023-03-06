import 'package:clients_digcoach/data/courts.dart';
import 'package:clients_digcoach/models/court.dart';

class CourtRepository {
  Future<List<Court>> getCourts() async {
    await Future.delayed(const Duration(milliseconds: 100));

    return courts;
  }

  Future<int> getCourtNumber(String clubId) async {
    await Future.delayed(const Duration(milliseconds: 100));

    return courts.where((court) => court.clubId == clubId).first.courtNumber;
  }

  Future<List<Court>> getCourtsByClubId(String clubId) async {
    await Future.delayed(const Duration(seconds: 1));

    return courts.where((court) => court.clubId == clubId).toList();
  }
}
