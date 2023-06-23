import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';

abstract class BaseFirebaseRealtimeDBRepository {
  Stream<List<HomeDisplay>> getHomeDisplayListRealTime();
  Stream<HomeDisplay> getHomeDisplayRealTime();
  Future<HomeDisplay?> getHomeDisplay();
  Future<void> addUserAccount(UserRequest request);

  Stream<List<TransactionHistory>> getTransactionListRealTime(String accountId, String searchQuery);
  Stream<TransactionHistory> getTransactionRealTime();

  Stream<List<Institution>> getInstitutionList();
}

class FirebaseRealtimeDBRepository extends BaseFirebaseRealtimeDBRepository {
  final FirebaseDatabase _firebaseDatabase;
  
  FirebaseRealtimeDBRepository({
    FirebaseDatabase? firebaseDatabase
  }): _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;

  // USER AUTH ID: =============================================================
  String userId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  // realtime list =============================================================
  @override
  Stream<List<HomeDisplay>> getHomeDisplayListRealTime() {
    return _firebaseDatabase.ref()
    .child('home_display')
    .orderByChild('owner_id')
    .equalTo(userId())
    .onValue
    .map((event) {
      List<HomeDisplay> homeDisplays = [];
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) {
          HomeDisplay homeDisplay = HomeDisplay.fromSnapshot(event.snapshot.child(key));
          homeDisplays.add(homeDisplay);
        });
      }
      return homeDisplays;
    }).handleError((error) {
      print('Error occurred: $error');
      return [];
    });
  }

  // realtime specific ===============================================================
  @override
  Stream<HomeDisplay> getHomeDisplayRealTime() {
    return _firebaseDatabase.ref('home_display')
    .child(userId())
    .limitToFirst(1)
    .onValue.map((event) {
      return HomeDisplay.fromSnapshot(event.snapshot);
    });
  }

  // not realtime: ==========================================================
  @override
  Future<HomeDisplay?> getHomeDisplay() async {
    final parentNodeRef = _firebaseDatabase.ref('home_display');
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

  // ============================================================ user request
  // =========================================================================
  @override
  Future<void> addUserAccount(UserRequest request) async {
    _firebaseDatabase
    .ref('user_request')
    .push()
    .set(request.toJson());
  }

  // ======================================================= transaction request
  // transaction query
  @override
  Stream<List<TransactionHistory>> getTransactionListRealTime(String accountId, String searchQuery) {
    Query query = _firebaseDatabase
      .ref('transaction_history')
      .child(userId())
      .child(accountId);

    if (searchQuery.isNotEmpty && searchQuery != "") {
      query = query.orderByChild('transaction_details').startAt(searchQuery).endAt(searchQuery + '\uf8ff');
    }

    return query.onValue.map((event) {
      List<TransactionHistory> transactions = [];
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        snapshotValues.forEach((key, values) {
          TransactionHistory history = TransactionHistory.fromSnapshot(event.snapshot.child(key));
          transactions.add(history);
        });
      }
      return transactions;
    }).handleError((error) {
      print('Error occurred: $error');
      return [];
    });
  }

  @override
  Stream<TransactionHistory> getTransactionRealTime() {
    return _firebaseDatabase.ref('transaction_history')
    .child(userId())
    .limitToFirst(1)
    .onValue.map((event) {
      return TransactionHistory.fromSnapshot(event.snapshot);
    });
  }

  // 
    // institution realtime list =============================================================
  @override
  Stream<List<Institution>> getInstitutionList() {
    return _firebaseDatabase.ref()
    .child('payment_institutions')
    .onValue
    .map((event) {
      List<Institution> institutions = [];
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) {
          Institution homeDisplay = Institution.fromSnapshot(event.snapshot.child(key));
          institutions.add(homeDisplay);
        });
      }
      return institutions;
    }).handleError((error) {
      print('Error occurred: $error');
      return [];
    });
  }
}