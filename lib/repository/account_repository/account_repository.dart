import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fcb_pay_app/repository/repository.dart';

abstract class BaseAccountRepository {
  Stream<List<Account>> getAllAccount();
}

class AccountRepository extends BaseAccountRepository {
  AccountRepository({
    FirebaseFirestore? firebaseFirestore
  }): _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _firebaseFirestore;

  @override
  Stream<List<Account>> getAllAccount() {
    return _firebaseFirestore.collection('accounts')
    .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .snapshots()
    .map((snapshot) {
      return snapshot.docs.map((items) => Account.fromSnapshot(items)).toList();
    });
  }
}