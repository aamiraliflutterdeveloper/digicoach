import 'package:clients_digcoach/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/coach_repository.dart';
import '../models/coach.dart';

final coachProvider = ChangeNotifierProvider((ref) => CoachProvider());

class CoachProvider extends ChangeNotifier {
  final _coachRepository = CoachRepository();

  int _coachesViewIndex = 0;
  int get coachesViewIndex => _coachesViewIndex;

  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  String? _selectedCoachId;
  String? get selectedCoachId => _selectedCoachId;

  List<Coach> _coaches = [];
  List<Coach> get coaches => _coaches;

  List<Coach> _coachesByClubId = [];
  List<Coach> get coachesByClubId => _coachesByClubId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isEdit = false;
  bool get isEdit => _isEdit;

  /// setters
  void _loading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set selectedCoachId(String? value) {
    _selectedCoachId = value;
    notifyListeners();
  }

  set coachesViewIndex(int value) {
    _coachesViewIndex = value;
    notifyListeners();
  }

  set tabIndex(int value) {
    _tabIndex = value;
    notifyListeners();
  }

  Future<void> removeCoachById(Coach coach, BuildContext context) async {
         try{
        WidgetUtils.loadingDialog(context, 'Removing Coach ....');
        final deletedManager = await _coachRepository.deleteManager(coach);
        _coaches.remove(deletedManager);
        notifyListeners();
        if(context.mounted) {
          Navigator.pop(context);
        }
      } on Exception catch(e) {
        if(context.mounted) {
          Navigator.pop(context);
        }
        WidgetUtils.buildDialog(context, child: Text("Something Wrong ${e.toString()}"));
      }

  }

  Future<String?> getCoachId(String id) async {
    selectedCoachId = await _coachRepository.getCoachId(id);
    notifyListeners();
    return selectedCoachId;
  }

  Future<void> getCoaches(BuildContext context) async {
    _loading(true);
    try {
      _coaches = await _coachRepository.getCoaches();
      notifyListeners();
      _loading(false);
    } on Exception catch(e) {
      _loading(false);
      WidgetUtils.buildDialog(context, child: Text("Something Wrong ${e.toString()}"));
    }
  }

  Future<List<Coach>> getCoachesByClubId(String id) async {
    _loading(true);
    _coachesByClubId = await _coachRepository.getCoachesByClubId(id);
    _loading(false);
    notifyListeners();
    return _coachesByClubId;
  }


  Future<void> addCoach(Coach coach, BuildContext context) async {
    try {
      WidgetUtils.loadingDialog(context, 'Creating New Coach ....');
      Coach completeCoach = await _coachRepository.addCoach(coach);
      _coaches.insert(0, completeCoach);
      notifyListeners();
      if(context.mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } on Exception catch(e) {
      if(context.mounted) {
        Navigator.pop(context);
      }
      WidgetUtils.buildDialog(context, child: Text("Something Wrong ${e.toString()}"));
    }
  }


  Future<void> updateCoach(Coach coach, BuildContext context) async {
    try{
      WidgetUtils.loadingDialog(context, 'Updating Coach ....');
      Coach completeCoach = await _coachRepository.updateManager(coach);

      /// update _coaches locally ...
      Coach relatedManager = _coaches.firstWhere((item)=>item.id == completeCoach.id);
      int index = _coaches.indexOf(relatedManager);
      _coaches[index] = completeCoach;

      notifyListeners();

      if(context.mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } on Exception catch(e) {
      if(context.mounted) {
        Navigator.pop(context);
      }
      WidgetUtils.buildDialog(context, child: Text("Something Wrong ${e.toString()}"));
    }
  }

  void setIsEdit(bool val) {
    _isEdit = val;
    notifyListeners();
  }
  Coach? currentCoach;

  set setCoachEditData(Coach coach) {
    currentCoach = coach;
    setIsEdit(true);
    notifyListeners();
  }

}





