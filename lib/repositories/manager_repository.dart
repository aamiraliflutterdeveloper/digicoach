import 'package:clients_digcoach/data/permissions.dart';
import 'package:clients_digcoach/models/club/manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ManagerRepository {

  final FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;

  /// add manager to firebase ...
  Future<Manager> addManager(Manager manager) async {

    final newManager = _firebaseInstance.collection('managers').doc();

    /// add list of photos to the firebase storage ...
    List<String> imagesUrl = [];
    try {
      if(manager.photoUrlInBytes!.isNotEmpty) {
        for (var i in manager.photoUrlInBytes!) {
          final folderPath = 'manager/${manager.name}${DateTime.now().millisecondsSinceEpoch}';
          TaskSnapshot snapshot = await FirebaseStorage.instance.ref().child(folderPath).putData(
            i,
            SettableMetadata(contentType: 'image/jpeg'),
          );
          String imgUrlNew = await snapshot.ref.getDownloadURL();
          imagesUrl.add(imgUrlNew);
        }
      }

      /// add document id as a manager id ...
      Manager completeManager = manager.copyWith(id: newManager.id, photoUrl: imagesUrl);

      /// send data to firebase ...
      await newManager.set(completeManager.toJson());
      return completeManager;
    } on Exception catch(e) {
      throw Exception(e);
    }
  }


  /// get managers from firebase ...
  Future<List<Manager>> getManagers() async {
    List<Manager> managers = [];
    try{
      QuerySnapshot managerSnapshot = await _firebaseInstance.collection('managers').get();
      managers = managerSnapshot.docs.map((doc) => Manager.fromJson(doc.data() as Map<String, dynamic>)).toList();
      if(managers.isNotEmpty) {
        return managers;
      }
    } on Exception catch(e) {
      throw Exception(e);
    }
    return managers;
  }

  /// update manager ...
  Future<Manager> updateManager(Manager manager) async {

    final updateManager = _firebaseInstance.collection('managers');

    /// update list of photos to the firebase storage ...
    List<String> imagesUrl = [];
    try {
      if(manager.photoUrlInBytes!.isNotEmpty) {
        for (var i in manager.photoUrlInBytes!) {
          final folderPath = 'manager/${manager.name}${DateTime.now().millisecondsSinceEpoch}';
          TaskSnapshot snapshot = await FirebaseStorage.instance.ref().child(folderPath).putData(
            i,
            SettableMetadata(contentType: 'image/jpeg'),
          );
          String imgUrlNew = await snapshot.ref.getDownloadURL();
          imagesUrl.add(imgUrlNew);
        }
      }

      /// add updated photos ...
      Manager completeManager = manager.copyWith(photoUrl: imagesUrl + manager.photoUrl!);

      /// update data ...
      await updateManager.doc(manager.id).update(completeManager.toJson());
      return completeManager;
    } on Exception catch(e) {
      throw Exception(e);
    }
  }


  /// delete manager
  Future<Manager> deleteManager(Manager manager) async {
    final updateManager = _firebaseInstance.collection('managers');

    for(var i in manager.photoUrl!) {
      final storage = FirebaseStorage.instance.ref().child(i);
      await storage.delete();
    }

    await updateManager.doc(manager.id).delete();
    return manager;
  }


  /// get permissions ...
  Future<List<Permission>> getPermissions() async {
    await Future.delayed(const Duration(milliseconds: 5));
    return permissions;
  }
}














