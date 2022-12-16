import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:fcb_pay_app/repository/model/account.dart';

abstract class BaseAccountRepository {
  Stream<List<Account>> getAllAccount();
  Future<Box> initializeBox();
  List<Account> getAccounts(Box box);
  Future<void> addAccount(Box box, Account hiveAccount);
  Future<void> updateAccount(Box box, Account hiveAccount);
  Future<void> deleteAccount(Box box, Account hiveAccount);
  Future<void> deleteAllAccounts(Box box);
}

class AccountRepository extends BaseAccountRepository {
  AccountRepository({
    FirebaseFirestore? firebaseFirestore
  }): _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _firebaseFirestore;
  String boxName = "Accounts";

  @override
  Stream<List<Account>> getAllAccount() {
    return _firebaseFirestore
    .collection('accounts')
    .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .snapshots()
    .map((snapshot) {
      return snapshot.docs.map((items) => Account.fromSnapshot(items)).toList();
    });
  }

  @override
  Future<Box> initializeBox() async {
    Box box = await Hive.openBox<Account>(boxName);
    return box;
  }

  @override
  List<Account> getAccounts(Box box) {
    return box.values.toList().cast<Account>();
  }

  @override
  Future<void> addAccount(Box box, Account hiveAccount) async {
    await box.add(hiveAccount);
  }

  @override
  Future<void> updateAccount(Box box, Account hiveAccount) async {
    await box.put(hiveAccount.userID, hiveAccount);
  }

  @override
  Future<void> deleteAccount(Box box, Account hiveAccount) async {
    await box.delete(hiveAccount.userID);
  }

  @override
  Future<void> deleteAllAccounts(Box box) async {
    await box.clear();
  }
}