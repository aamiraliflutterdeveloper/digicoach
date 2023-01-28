import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/coach_repository.dart';
import '../models/coach.dart';

final coachProvider = ChangeNotifierProvider((ref) => CoachService());

class CoachService extends ChangeNotifier {
  final CoachRepository _coachRepository = CoachRepository();

  Future<Coach> getCoach(String id) async {
    return await _coachRepository.getCoach(id);
  }

  Future<List<Coach>> getCoaches() async {
    return await _coachRepository.getCoaches();
  }
}
