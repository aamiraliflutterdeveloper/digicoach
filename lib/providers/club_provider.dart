import 'package:clients_digcoach/models/club/club.dart';
import 'package:clients_digcoach/models/club/manager.dart';
import 'package:clients_digcoach/repositories/club_repository.dart';
import 'package:clients_digcoach/repositories/manager_repository.dart';
import 'package:clients_digcoach/utils/widget_utils.dart';
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

  bool _isFromEdit = false;
  bool get isFromEdit => _isFromEdit;

  Manager? _currentManager;
  Manager? get currentManager => _currentManager;



  bool _manageAllClubs = false;

  bool? get getManageClub => _manageAllClubs;

  List<Permission> _permissions = [];

  List<Permission>? get permissions => _permissions;

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

  set manageAllClub(bool manage) {
    _manageAllClubs = manage;
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


  Future<void> removeManagerById(Manager manager, BuildContext context) async {
    try{
      WidgetUtils.loadingDialog(context, 'Removing Manager ....');
     final deletedManager = await _managerRepository.deleteManager(manager);
      _managers.remove(deletedManager);
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


  Future<void> getManagers(BuildContext context) async {
    try{
      _loading(true);
      final managers = await _managerRepository.getManagers();
      _managers = managers;
      notifyListeners();
      _loading(false);
    } on Exception catch(e) {
      _loading(false);
      WidgetUtils.buildDialog(context, child: Text("Something Wrong ${e.toString()}"));
    }
  }



  Future<void> addManager(Manager manager, BuildContext context) async {
    try{
      WidgetUtils.loadingDialog(context, 'Creating New Manager ....');
      Manager completeManager = await _managerRepository.addManager(manager);
      /// add managers locally ...
      _managers.insert(0, completeManager);
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



  Future<void> updateManager(Manager manager, BuildContext context) async {
    try{
      WidgetUtils.loadingDialog(context, 'Updating Manager ....');
      Manager completeManager = await _managerRepository.updateManager(manager);

      /// update managers locally ...
     Manager relatedManager = _managers.firstWhere((item)=>item.id == completeManager.id);
      int index = _managers.indexOf(relatedManager);
      _managers[index] = completeManager;

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


  Future<List<Permission>?> getPermissions() async {
      for(int i =0; i<_permissions.length; i++) {
        _permissions[i].copyWith(read: true);
        _permissions[i].copyWith(readWrite: true);
      }
    _permissions = await _managerRepository.getPermissions();
    notifyListeners();
    return _permissions;
  }

  updateRead(int id, val) {
    _permissions[id] = _permissions[id].copyWith(read: val);
    notifyListeners();
  }

  updateReadWrite(int id, val) {
    _permissions[id] = _permissions[id].copyWith(readWrite: val);
    notifyListeners();
  }

  void setEditPermissions(List<Permission>? permissions) {
    _permissions = permissions!;
    notifyListeners();
  }

  void setIsFromEdit(bool val) {
    _isFromEdit = val;
    notifyListeners();
  }

  set setManagerEditData(Manager manager) {
    _currentManager = manager;
    setIsFromEdit(true);
    notifyListeners();
  }



}







