import 'package:clients_digcoach/data/coaches.dart';

import '../models/coach.dart';

class CoachRepository {
  Future<void> removeCoachById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));

    coaches = List.from(coaches)..removeWhere((coach) => coach.id == id);
    print('Remove id: $id ${coaches.length}');
  }

  Future<List<Coach>> getCoachesByClubId(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));

    return List.of(coaches)
        .where((coach) => coach.clubsId.contains(id))
        .toList();
  }

  Future<String> getCoachId(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));

    return List.of(coaches)
        .where((coach) => coach.clubsId.contains(id))
        .first
        .id;
  }

  Future<List<Coach>> getCoaches() async {
    await Future.delayed(const Duration(milliseconds: 100));

    return coaches;
  }
}
