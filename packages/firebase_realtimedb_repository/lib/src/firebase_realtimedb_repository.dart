import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';

class FirebaseRealtimeDBRepository {
  final FirebaseDatabase _firebaseDatabase;
  
  FirebaseRealtimeDBRepository({
    FirebaseDatabase? firebaseDatabase
  }): _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;

  // USER_AUTH_ID ================================
  String userId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  // ======================================================== USER ACCOUNTS ===================
  // ==========================================================================================
  // GET accounts list (stream)
  Stream<List<Accounts>> getAccountListStream() {
    return _firebaseDatabase
    .ref()
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

  // GET account (stream)
  Stream<Accounts> getAccountStream() {
    return _firebaseDatabase
    .ref('user_account')
    .child(userId())
    .limitToFirst(1)
    .onValue.map((event) {
      return Accounts.fromSnapshot(event.snapshot);
    });
  }

  // GET account
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

  // ================================= USER REQUEST ============
  // ===========================================================
  // ADD user request
  Future<String?> addUserRequest(UserRequest request) async {
    try {
      final ref = _firebaseDatabase.ref('user_request').push();
      ref.set(request.toJson());
      return ref.key;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  // ======================================================= TRANSACTION HISTORY ============================
  // ========================================================================================================
  // GET transaction history list (stream)
  Stream<List<TransactionHistory>> getTransactionHistoryListStream(String accountId) {
    Query query = _firebaseDatabase
    .ref('transaction_history') // parent node
    .child(userId())  // user id
    .child(accountId);  // account id

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

  // GET transaction history (stream)
  Stream<TransactionHistory> getTransactionHistoryStream() {
    return _firebaseDatabase.ref('transaction_history')
    .child(userId())
    .limitToFirst(1)
    .onValue.map((event) {
      return TransactionHistory.fromSnapshot(event.snapshot);
    });
  }

  // ======================================================= TRANSACTION FILTER ============================
  // ========================================================================================================
  // GET transaction filter (stream)
  Stream<TransactionFilter> getTransactionFilterStream() {
    return _firebaseDatabase
    .ref('transaction_filter')
    .onValue.map((event) {
      return TransactionFilter.fromSnapshot(event.snapshot);
    }).handleError((error) {
      print('Error occurred: $error');
      return [];
    });
  }

  // ================================= BILLING INSTITUTIONS ===================================
  // ==========================================================================================
  // GET billing institutions list (stream)
  Stream<List<Institution>> getInstitutionListStream() {
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

  // =================================================== FUND TRANSFERS ==============================
  // =================================================================================================
  // GET fund transfers list (stream)
  Stream<List<FundTransferAccount>> getFundTransferListStream() {
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

  // =============================================================== USERS WIDGET ========
  // =====================================================================================
  // GET user widgets list
  Future<List<UserWidget>> getUserWidgetList(String instId) {
    return _firebaseDatabase
    .ref('user_widget') // parent node
    .child(userId())  // user id
    .child(instId)  // institution id
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
    }).onError((error, stackTrace) {
      print('Error occurred: $error');
      return [];
    });
  }

  // ============================ RECEIPTS ============
  // ==================================================
  // GET receipt
  Stream<Receipts> getReceiptStream(String id) {
    return _firebaseDatabase.ref('receipts')
    .child(userId())
    .child(id)
    .onValue
    .map((event) {
      return Receipts.fromSnapshot(event.snapshot);
    });
  }

  // ========================================== NOTIFICATIONS ===================================
  // ============================================================================================
  // GET notification list (stream)
  Stream<List<Notifications>> getNotificationListStream() {
    return _firebaseDatabase.ref()
    .child('notifications/${userId()}')
    .onValue
    .map((event) {
      List<Notifications> notificationList = [];

      if (event.snapshot.exists) {
        Map<dynamic, dynamic> snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) {
          Notifications notification = Notifications.fromSnapshot(event.snapshot.child(key));
          notificationList.add(notification);
        });
      }
      
      return notificationList;
    }).handleError((error) {
      throw('Error occurred: $error');
    });
  }

  // GET notification
  Future<Notifications> getNotification(String id) async {
    try {
      final snapshot = await _firebaseDatabase.ref()
      .child('notifications/${userId()}/${id}')
      .get();

      if (snapshot.exists) {
        return Notifications.fromSnapshot(snapshot);
      } else {
        throw Exception('Notification with ID $id not found');
      }
    } catch (error) {
      throw Exception('Failed to retrieve notification');
    }
  }

  // UPDATE notification
  Future<void> updateNotificationRead(String id) async {
    try {
      await _firebaseDatabase.ref()
      .child('notifications/${userId()}/${id}')
      .update({'is_read': true});
    } catch (error) {
      throw('Error marking notification as read: $error');
    }
  }

  // DELETE notification
  Future<void> deleteNotificationRead(String id) async {
    try {
      await _firebaseDatabase.ref()
      .child('notifications/${userId()}/${id}')
      .remove();
    } catch (error) {
      print('Error deleting notification: $error');
    }
  }

  // ========================================== HOME BUTTONS ===================================
  // ============================================================================================
  // GET home_buttons list (stream)
  Stream<List<HomeButton>> getHomeButtonsListStream() {
    return _firebaseDatabase.ref('home_buttons')
    .onValue
    .map((event) {
      List<HomeButton> homeButtonsList = [];

      if (event.snapshot.exists) {
        final snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) {
          HomeButton homeButton = HomeButton.fromSnapShot(event.snapshot.child(key));
          homeButtonsList.add(homeButton);
        });
      }
      
      return homeButtonsList;
    }).handleError((error) {
      throw('Error occurred: $error');
    });
  }
}