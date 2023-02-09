import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final scheduleProvider = ChangeNotifierProvider((ref) => ScheduleProvider());

class ScheduleProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
