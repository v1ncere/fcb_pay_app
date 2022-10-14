// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcb_pay_app/repository/model/account.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  Future<List<AccountModel>> getData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("accounts").get();
    return snapshot.docs.map((docSnapshot) => AccountModel.fromDocumentSnapshot(docSnapshot)).toList();
  }
}