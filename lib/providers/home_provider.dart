import 'package:clients_digcoach/models/end_drawer_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = ChangeNotifierProvider((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  EndDrawerPopup _endDrawerPopup = EndDrawerPopup.addManager;
  EndDrawerPopup get endDrawerPopup => _endDrawerPopup;
  set endDrawerPopup(EndDrawerPopup endDrawerPopup) {
    _endDrawerPopup = endDrawerPopup;
    notifyListeners();
  }

  /// end drawer status ...
  bool _endDrawerStatus = false;
  bool get endDrawerStatus => _endDrawerStatus;

  set endDrawerChanges(bool status) {
    _endDrawerStatus = status;
    notifyListeners();
  }

}
