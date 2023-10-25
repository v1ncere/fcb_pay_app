import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';

class FirebaseRealtimeDBRepository {
  final FirebaseDatabase _firebaseDatabase;
  
  FirebaseRealtimeDBRepository({
    FirebaseDatabase? firebaseDatabase
  })  : _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;

  // USER_AUTH_ID
  String userId() => FirebaseAuth.instance.currentUser!.uid;

  // ===================================== ACCOUNT ===========================
  // =========================================================================
  // GET accounts list (stream)
  Stream<List<Account>> getAccountListStream() {
    return _firebaseDatabase.ref('account/${userId()}')
    .onValue
    .map((event) {
      List<Account> accountList = [];

      if (event.snapshot.exists) {
        final snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;

        snapshotValues.forEach((key, values) {
          Account account = Account.fromSnapshot(event.snapshot.child(key));
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
  Stream<Account> getAccountStream() {
    return _firebaseDatabase.ref('account')
    .child(userId())
    .limitToFirst(1)
    .onValue.map((event) {
      return Account.fromSnapshot(event.snapshot);
    });
  }

  // GET account
  Future<Account?> getAccounts() async {
    final parentNodeRef = _firebaseDatabase.ref('account');
    final valueQuery = parentNodeRef
    .child(userId());
    // .orderByChild("owner_id")
    // .equalTo(userId());

    final snap = await valueQuery.get();

    if (snap.value != null) {
      final values = snap.value as Map<dynamic, dynamic>;
      final childNodeKey = values.keys.first;
      final snapshot = await parentNodeRef.child(childNodeKey).get();

      final reply = Account.fromSnapshot(snapshot);
      return reply;
    } else {
      return null;
    }
  }

  // ===================== USER REQUEST ========================
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

  // ======================================== TRANSACTION HISTORY =====================================
  // ==================================================================================================
  // GET transaction history list (stream)
  Stream<List<TransactionHistory>> getTransactionHistoryListStream(String accountId) {
    Query query = _firebaseDatabase.ref('transaction_history/${userId()}/${accountId}');

    return query.onValue.map((event) {
      List<TransactionHistory> transactionList = [];
      
      if (event.snapshot.exists) {
        final snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) { // do the value not use?
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

  // // ================================= BILLING INSTITUTIONS ===============================
  // // ======================================================================================
  // // GET billing institutions list (stream)
  // Stream<List<Institutions>> getInstitutionListStream() {
  //   return _firebaseDatabase.ref('billing_institution')
  //   .onValue
  //   .map((event) {
  //     List<Institutions> institutionList = [];

  //     if (event.snapshot.exists) {
  //       final snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
  //       snapshotValues.forEach((key, values) {
  //         Institutions institution = Institutions.fromSnapshot(event.snapshot.child(key));
  //         institutionList.add(institution);
  //       });
  //     }

  //     return institutionList;
  //   }).handleError((error) {
  //     print('Error occurred: $error');
  //     return [];
  //   });
  // }

  // // =================================================== FUND TRANSFERS =============================
  // // ================================================================================================
  // // GET fund transfers list (stream)
  // Stream<List<FundTransferAccount>> getFundTransferListStream() {
  //   return _firebaseDatabase.ref('fund_transfer')
  //   .child(userId())
  //   .onValue
  //   .map((event) {
  //     List<FundTransferAccount> accountList = [];
  //     if (event.snapshot.exists) {
  //       Map<dynamic, dynamic> snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
  //       snapshotValues.forEach((key, values) {
  //         FundTransferAccount account = FundTransferAccount.fromSnapshot(event.snapshot.child(key));
  //         accountList.add(account);
  //       });
  //     }
  //     return accountList;
  //   }).handleError((error) {
  //     print('Error occurred: $error');
  //     return [];
  //   });
  // }

  // ============================= USERS WIDGET =============================
  // ========================================================================
  // GET user widgets list
  Future<List<ExtraWidget>> getExtraWidgetList(String instId) {
    return _firebaseDatabase.ref('extra_widget/${instId}')
    .get()
    .then((snapshot) {
      List<ExtraWidget> extraWidgetList = [];

      if (snapshot.exists) {
        final snapshotValues = snapshot.value as Map<dynamic, dynamic>;
        snapshotValues.forEach((key, values) {
          ExtraWidget extra = ExtraWidget.fromSnapshot(snapshot.child(key));
          extraWidgetList.add(extra);
        });
      }
      return extraWidgetList;
    }).onError((error, stackTrace) {
      print('Error occurred: $error');
      return [];
    });
  }

  // ============================ RECEIPTS ==================
  // ========================================================
  // GET receipt
  Stream<Receipt> getReceiptStream(String id) {
    return _firebaseDatabase.ref('receipt/${userId()}/${id}')
    .onValue
    .map((event) {
      return Receipt.fromSnapshot(event.snapshot);
    });
  }

  // GET receipt
  Stream<Map<String, dynamic>> getDynamicReceiptStream(String id) {
    return _firebaseDatabase.ref('receipt/${userId()}/${id}')
    .onValue
    .map((event) {
      Map<String, dynamic> mapper = {};

      if (event.snapshot.exists) {
      final snapshotValue = event.snapshot.value as Map<dynamic, dynamic>;
      
      snapshotValue.forEach((key, values) {
        Map<String, dynamic> newMap = {key: values};
        mapper.addEntries(newMap.entries);
      });
    }

      return mapper;
    });
  }

  // ====================================== NOTIFICATION ===================================
  // =======================================================================================
  // GET notification list (stream)
  Stream<List<Notification>> getNotificationListStream() {
    return _firebaseDatabase.ref('notification/${userId()}')
    .onValue
    .map((event) {
      List<Notification> notificationList = [];

      if (event.snapshot.exists) {
        final snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) {
          Notification notification = Notification.fromSnapshot(event.snapshot.child(key));
          notificationList.add(notification);
        });
      }
      
      return notificationList;
    }).handleError((error) {
      throw('Error occurred: $error');
    });
  }

  // GET notification
  Future<Notification> getNotification(String id) async {
    try {
      final snapshot = await _firebaseDatabase
      .ref('notification/${userId()}/${id}')
      .get();

      if (snapshot.exists) {
        return Notification.fromSnapshot(snapshot);
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
      await _firebaseDatabase
      .ref('notification/${userId()}/${id}')
      .update({'is_read': true});
    } catch (error) {
      throw('Error marking notification as read: $error');
    }
  }

  // DELETE notification
  Future<void> deleteNotificationRead(String id) async {
    try {
      await _firebaseDatabase
      .ref('notification/${userId()}/${id}')
      .remove();
    } catch (error) {
      print('Error deleting notification: $error');
    }
  }

  // ========================================== HOME BUTTONS =========================
  // =================================================================================
  // GET home_button list (stream)
  Stream<List<HomeButton>> getHomeButtonsListStream() {
    return _firebaseDatabase.ref('home_button')
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
      print('Error occurred: $error');
      return [];
    });
  }

  // GET home_button (specific data)
  Future<HomeButton?> getHomeButton(String id) {
    return _firebaseDatabase.ref('home_button/$id')
    .get()
    .then((snapshot) {
      if (snapshot.exists) {
        return HomeButton.fromSnapShot(snapshot);
      }
      return null;
    }).onError((error, stackTrace) {
      print(error);
      return null;
    });
  }

  // ========================================== PAGE WIDGETS ======================
  // ==============================================================================
  // GET page_widget list (stream)
  Stream<List<PageWidget>> getWidgetsListStream(String originId) {
    return _firebaseDatabase
    .ref('page_widget/${originId}')
    .onValue
    .map((event) {
      List<PageWidget> widgetsList = [];
      // Check if data exists at the specified database location
      if (event.snapshot.exists) {
        // Extract the data as a map of key-value pairs
        final snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        // Iterate through the map and convert data to HomeButtonWidget objects
        snapshotValues.forEach((key, values) {
          // Create a HomeButtonWidget object from the child snapshot at the current key
          PageWidget widget = PageWidget.fromSnapshot(event.snapshot.child(key));
          // Add the newly created widget to the list
          widgetsList.add(widget);
        });
      }
      // Return the list of HomeButtonWidget objects as a stream
      return widgetsList;
    })
    // Handle any errors that might occur during the stream
    .handleError((error) {
      // Throw an error message
      throw('Error occurred: $error');
    });
  }

  // ============================ LIST STRING DATA =========================
  // =======================================================================
  // GET dynamic dropdown list
  Future<List<String>> getDynamicListStringData(String reference) async {
    return _firebaseDatabase.ref(reference)
    .get()
    .then((snapshot) {
      List<String> filters = [];

      if (snapshot.exists) {
        // cast snapshot as List<dynamic> base on firebase node List format
        final filterList = snapshot.value as List<dynamic>;

        for (var value in filterList) {
          //  filter out any null values and include all non-null values
          if (value != null) {
            filters.add(value);
          }
        }
      }
      return filters;
    }).onError((error, stackTrace) {
      print('Error occurred: $error');
      return [];
    });
  }
}