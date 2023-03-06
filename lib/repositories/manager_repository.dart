import 'package:clients_digcoach/data/clubs.dart';
import 'package:clients_digcoach/data/managers.dart';
import 'package:clients_digcoach/data/opening_hours.dart';
import 'package:clients_digcoach/models/club/manager.dart';
import '../models/club/opening_time.dart';
import '../models/club/club.dart';

class ManagerRepository {
  Future<void> removeManagerById(String id) async {
    await Future.delayed(const Duration(seconds: 1));

    managers.removeWhere((manager) => manager.id == id);
  }

  Future<void> addManager(Manager manager) async {
    await Future.delayed(const Duration(seconds: 1));
    managers.add(manager);
  }

  Future<List<Manager>> getManagers() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return managers;
  }
}
