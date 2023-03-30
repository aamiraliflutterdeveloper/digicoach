import 'package:clients_digcoach/data/coaches.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/coach.dart';

class CoachRepository {

  final FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;

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
    /// get managers from firebase ...
      List<Coach> coaches = [];
      try{
        QuerySnapshot managerSnapshot = await _firebaseInstance.collection('coaches').get();
        coaches = managerSnapshot.docs.map((doc) => Coach.fromJson(doc.data() as Map<String, dynamic>)).toList();
        if(coaches.isNotEmpty) {
          return coaches;
        }
      } on Exception catch(e) {
        throw Exception(e);
      }
      return coaches;
  }

  /// add coach to the firebase ...
  Future<Coach> addCoach(Coach coach) async {

    final newCoach = _firebaseInstance.collection('coaches').doc();
    List<String> imagesUrl = [];
    try {
      if(coach.photoUrlInBytes!.isNotEmpty) {
        for (var i in coach.photoUrlInBytes!) {
          final folderPath = 'coach/${coach.name}${DateTime.now().millisecondsSinceEpoch}';
          TaskSnapshot snapshot = await FirebaseStorage.instance.ref().child(folderPath).putData(
            i,
            SettableMetadata(contentType: 'image/jpeg'),
          );
          String imgUrlNew = await snapshot.ref.getDownloadURL();
          imagesUrl.add(imgUrlNew);
        }
      }
      /// add document id as a manager id ...
      Coach completeCoach = coach.copyWith(id: newCoach.id, photoUrl: imagesUrl);
      /// send data to firebase ...
      await newCoach.set(completeCoach.toJson());
      return completeCoach;
    } on Exception catch(e) {
      throw Exception(e);
    }
  }



  /// update coach ...
  Future<Coach> updateManager(Coach coach) async {

    final updateCoach = _firebaseInstance.collection('coaches');
    /// update list of photos to the firebase storage ...
    List<String> imagesUrl = [];
    try {
      if(coach.photoUrlInBytes!.isNotEmpty) {
        for (var i in coach.photoUrlInBytes!) {
          final folderPath = 'coach/${coach.name}${DateTime.now().millisecondsSinceEpoch}';
          TaskSnapshot snapshot = await FirebaseStorage.instance.ref().child(folderPath).putData(
            i,
            SettableMetadata(contentType: 'image/jpeg'),
          );
          String imgUrlNew = await snapshot.ref.getDownloadURL();
          imagesUrl.add(imgUrlNew);
        }
      }
      /// add updated photos ...
      Coach completeCoach = coach.copyWith(photoUrl: imagesUrl + coach.photoUrl!);
      /// update data ...
      await updateCoach.doc(coach.id).update(completeCoach.toJson());
      return completeCoach;
    } on Exception catch(e) {
      throw Exception(e);
    }
  }


  /// delete coach ...
  Future<Coach> deleteManager(Coach coach) async {
    final updateManager = _firebaseInstance.collection('coaches');

    for(var i in coach.photoUrl!) {
      final storage = FirebaseStorage.instance.ref().child(i);
      await storage.delete();
    }

    await updateManager.doc(coach.id).delete();
    return coach;
  }


}
