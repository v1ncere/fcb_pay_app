import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcb_pay_app/repository/account_repository/base_account_repo.dart';
import 'package:fcb_pay_app/repository/model/account.dart';

class AccountRepository extends BaseAccountRepository {
  final FirebaseFirestore _firebaseFirestore;

  AccountRepository({FirebaseFirestore? firebaseFirestore})
    : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<AccountModel>> getAllAccount() {
    return _firebaseFirestore
    .collection('accounts')
    .snapshots()
    .map((snapshot) {
      return snapshot.docs.map((items) => AccountModel.fromSnapshot(items)).toList();
    });
  }
}