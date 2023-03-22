import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:fcb_pay_app/repository/repository.dart';

abstract class BaseFirebaseDatabaseService {
  Stream<HomeDisplay> getHomeDisplayRealTime();
  Future<HomeDisplay?> getHomeDisplay();
}

class FirebaseDatabaseService extends BaseFirebaseDatabaseService {
  final FirebaseDatabase _firebaseDatabase;
  
  FirebaseDatabaseService({
    FirebaseDatabase? firebaseDatabase
  }): _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;

  // realtime ===============================================================
  @override
  Stream<HomeDisplay> getHomeDisplayRealTime() {
    return _firebaseDatabase.ref("home_display")
    .child(userId())
    .limitToFirst(1)
    .onValue.map((event) {
      return HomeDisplay.fromSnapshot(event.snapshot);
    });
    
  }

  // not realtime: ==========================================================
  @override
  Future<HomeDisplay?> getHomeDisplay() async {
    final parentNodeRef = _firebaseDatabase.ref("home_display");
    final valueQuery = parentNodeRef
    .orderByChild("owner_id")
    .equalTo(userId());

    final snap = await valueQuery.get();

    if (snap.value != null) {
      final values = snap.value as Map<dynamic, dynamic>;
      final childNodeKey = values.keys.first;
      final snapshot = await parentNodeRef.child(childNodeKey).get();

      final reply = HomeDisplay.fromSnapshot(snapshot);
      return reply;
    } else {
      return null;
    }
  }

  // user id: ================================================================

  String userId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}