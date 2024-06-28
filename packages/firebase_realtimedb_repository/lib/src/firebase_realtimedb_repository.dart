import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../firebase_realtimedb_repository.dart';

class FirebaseRealtimeDBRepository {
  FirebaseRealtimeDBRepository({
    FirebaseDatabase? firebaseDatabase
  })  : _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;
  final FirebaseDatabase _firebaseDatabase;
  
  // USER_AUTH_ID
  String userId() => FirebaseAuth.instance.currentUser!.uid;

  // ==================================================================================== ACCOUNT =====
  // ==================================================================================================
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

  // =============================================================================== USER REQUEST =====
  // ==================================================================================================
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

  // ======================================================================== TRANSACTION HISTORY =====
  // ==================================================================================================
  // GET transaction history list (stream)
  Stream<List<TransactionHistory>> getTransactionHistoryListStream(String accountId, int limit) {
    Query query = _firebaseDatabase
    .ref('transaction_history/${userId()}/${accountId}')
    .limitToFirst(limit);

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

  // GET transaction history
  Future<TransactionHistory> getTransactionHistory(String reference) async {
    try {
      final snapshot = await _firebaseDatabase
      .ref('transaction_history/$userId()/$reference') // reference is 'accountId/detailsId'
      .get();
      
      if (snapshot.exists) {
        return TransactionHistory.fromSnapshot(snapshot);
      } else {
        throw(Exception('Something went wrong!'));
      }
    } catch (e) {
      throw(Exception(e.toString()));
    }
  }

  // =================================================================== INSTITUTION EXTRA WIDGET =====
  // ==================================================================================================
  // GET user widgets list
  Future<List<ExtraWidget>> getInstitutionExtraWidgetList(String instId) {
    return _firebaseDatabase.ref('institution_extra_widget/${instId}')
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

  // ==================================================================================== RECEIPT =====
  // ==================================================================================================
  // GET receipt
  Stream<Receipt> getReceiptStream(String id) {
    return _firebaseDatabase.ref('receipt/${userId()}/${id}')
    .onValue
    .map((event) {
      if (event.snapshot.exists) {
        return Receipt.fromSnapshot(event.snapshot);
      } else {
        return Receipt.empty;
      }
    });
  }

  // GET receipt
  Stream<Map<String, dynamic>> getDynamicReceiptStream(String id) {
    return _firebaseDatabase
    .ref('receipt/${userId()}/${id}')
    .onValue
    .map((event) {
      Map<String, dynamic> map = {};

      if (event.snapshot.exists) {
        final snapshotValue = event.snapshot.value as Map<dynamic, dynamic>;
        snapshotValue.forEach((key, values) {
          Map<String, dynamic> newMap = {key: values};
          map.addEntries(newMap.entries);
        });
      }
      return map;
    });
  }

  // =============================================================================== NOTIFICATION =====
  // ==================================================================================================
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
    } catch (_) {
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

  // ==================================================================================== BUTTONS =====
  // ==================================================================================================
  // GET button list (stream)
  Stream<List<Button>> getButtonListStream() {
    return _firebaseDatabase.ref('button')
    .onValue
    .map((event) {
      List<Button> buttonList = [];

      if (event.snapshot.exists) {
        final snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;
        
        snapshotValues.forEach((key, values) {
          Button button = Button.fromSnapShot(event.snapshot.child(key));
          buttonList.add(button);
        });
      }
      
      return buttonList;
    }).handleError((_) {
      return [];
    });
  }

  // GET button (specific data)
  Future<Button?> getButton(String id) {
    return _firebaseDatabase.ref('button/$id')
    .get()
    .then((snapshot) {
      if (snapshot.exists) {
        return Button.fromSnapShot(snapshot);
      }
      return null;
    }).onError((error, stackTrace) {
      return null;
    });
  }

  // ===================================================================== DYNAMIC VIEWER WIDGETS =====
  // ==================================================================================================
  // GET page_widget list (stream)
  Stream<List<PageWidget>> getWidgetsListStream(String originId) {
    return _firebaseDatabase
    .ref('dynamic_viewer_widget/${originId}')
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

  // =========================================================================== LIST STRING DATA =====
  // ==================================================================================================
  // GET dynamic dropdown list
  Future<List<String>> getDynamicListStringData(String reference) async {
    return _firebaseDatabase
    .ref(reference)
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

  // ============================================================================= SIGN UP VERIFY =====
  // ==================================================================================================
  // SEND VERIFICATION DETAILS
  Future<String?> addAccountVerification(AccountVerify req) async {
    try {
      final ref = _firebaseDatabase.ref('signup_verify').push();
      await ref.set(req.toJson());
      
      return ref.key;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // ======================================================================= SIGN UP VERIFY REPLY =====
  // ==================================================================================================
  // GET VERIFICATION
  Stream<AccountVerify> getSignupVerifyReply(String id) {
    return _firebaseDatabase.ref('signup_verify_reply/${id}')
    .onValue
    .map((event) {
      if (event.snapshot.exists) {
        return AccountVerify.fromSnapshot(event.snapshot);
      } else {
        return AccountVerify.empty;
      }
    });
  }

  // ============================================================================= ACCOUNT PUBLIC =====
  // ==================================================================================================
  // ACCOUNT EXISTS
  Future<bool> isAccountUsed(String encryptedAccount) async {
    try {
      final snapshot = await _firebaseDatabase
      .ref('account_public/${encryptedAccount}')
      .get();

      return snapshot.exists;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // =============================================================================== USER DETAILS =====
  // ==================================================================================================

  // add user details
  Future<String?> addUserDetails(UserDetails userDetails) async {
    try {
      final ref = _firebaseDatabase.ref('user_details/${userId()}');
      await ref.set(userDetails.toJson())
      .catchError((e) {
        throw Exception(e.toString());
      });
      
      return ref.key;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  // add get user details
  Stream<UserDetails> getUserDetails() {
    return _firebaseDatabase.ref('user_details/${userId()}')
    .onValue
    .map((event) {
      return UserDetails.fromSnapshot(event.snapshot);
    }).handleError((error) {
      return [];
    });
  }
}