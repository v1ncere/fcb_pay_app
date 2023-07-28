import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';

abstract class BaseFirebaseRealtimeDBRepository {
  Stream<List<Accounts>> getAccountsListRealTime();
  Stream<Accounts> getAccountRealTime();
  Future<Accounts?> getAccounts();
  Future<void> addUserAccount(UserRequest request);
  Stream<List<TransactionHistory>> getTransactionListRealTime(String accountId, String searchQuery);
  Stream<TransactionHistory> getTransactionRealTime();
  Stream<List<Institution>> getInstitutionList();
  Stream<List<FundTransferAccount>> getFundTransferList();
  Future<List<UserWidget>> getUserWidgetList(String institution);
}

class FirebaseRealtimeDBRepository extends BaseFirebaseRealtimeDBRepository {
  final FirebaseDatabase _firebaseDatabase;
  
  FirebaseRealtimeDBRepository({
    FirebaseDatabase? firebaseDatabase
  }): _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;

  // realtime get all accounts
  @override
  Stream<List<Accounts>> getAccountsListRealTime() {
    return _firebaseDatabase.ref()
    .child('user_account')
    .child(userId())
    .onValue
    .map((event) {
      List<Accounts> accountList = [];

      if (event.snapshot.exists) {
        Map<dynamic, dynamic> snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) {
          Accounts account = Accounts.fromSnapshot(event.snapshot.child(key));
          accountList.add(account);
        });
      }
      
      return accountList;
    }).handleError((error) {
      print('Error occurred: $error');
      return [];
    });
  }

  // realtime get account
  @override
  Stream<Accounts> getAccountRealTime() {
    return _firebaseDatabase.ref('user_account')
    .child(userId())
    .limitToFirst(1)
    .onValue.map((event) {
      return Accounts.fromSnapshot(event.snapshot);
    });
  }

  // not realtime:
  @override
  Future<Accounts?> getAccounts() async {
    final parentNodeRef = _firebaseDatabase.ref('user_account');
    final valueQuery = parentNodeRef
    .child(userId());
    // .orderByChild("owner_id")
    // .equalTo(userId());

    final snap = await valueQuery.get();

    if (snap.value != null) {
      final values = snap.value as Map<dynamic, dynamic>;
      final childNodeKey = values.keys.first;
      final snapshot = await parentNodeRef.child(childNodeKey).get();

      final reply = Accounts.fromSnapshot(snapshot);
      return reply;
    } else {
      return null;
    }
  }

  // ============================================================== user request
  // ===========================================================================
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
      List<TransactionHistory> transactionList = [];
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) {
          TransactionHistory transaction = TransactionHistory.fromSnapshot(event.snapshot.child(key));
          transactionList.add(transaction);
        });
      }

      return transactionList;
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

  // ===============================================realtime get all institution
  @override
  Stream<List<Institution>> getInstitutionList() {
    return _firebaseDatabase.ref()
    .child('billing_institution')
    .onValue
    .map((event) {
      List<Institution> institutionList = [];

      if (event.snapshot.exists) {
        Map<dynamic, dynamic> snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) {
          Institution institution = Institution.fromSnapshot(event.snapshot.child(key));
          institutionList.add(institution);
        });
      }

      return institutionList;
    }).handleError((error) {
      print('Error occurred: $error');
      return [];
    });
  }

  // =================================================== fund transfers accounts
  // realtime get all fundtransfer account
  @override
  Stream<List<FundTransferAccount>> getFundTransferList() {
    return _firebaseDatabase.ref()
    .child('fund_transfer')
    .child(userId())
    .onValue
    .map((event) {
      List<FundTransferAccount> accountList = [];
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) {
          FundTransferAccount account = FundTransferAccount.fromSnapshot(event.snapshot.child(key));
          accountList.add(account);
        });
      }
      return accountList;
    }).handleError((error) {
      print('Error occurred: $error');
      return [];
    });
  }

  // =============================================================== user_widget
  // get user widget base on institution
  @override
  Future<List<UserWidget>> getUserWidgetList(String institution) {
    return _firebaseDatabase
    .ref()
    .child('user_widget')
    .child(userId())
    .child(institution)
    .get()
    .then((snapshot) {
      List<UserWidget> widgetList = [];

      if (snapshot.exists) {
        Map<dynamic, dynamic> snapshotValues = snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) {
          UserWidget account = UserWidget.fromSnapshot(snapshot.child(key));
          widgetList.add(account);
        });
        
      }
      return widgetList;
    }).onError((error, stackTrance) {
      print('Error occurred: $error');
      return [];
    });
  }

  // USER_AUTH_ID
  String userId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}