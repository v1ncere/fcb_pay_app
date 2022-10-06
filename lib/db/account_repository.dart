// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcb_pay_app/db/model/account.dart';
import 'package:flutter/foundation.dart';

class AccountRepository {
  final _fireStore = FirebaseFirestore.instance.collection("accounts");

  Future<void> create({required int account, required int balance, required int walletBalance}) async {
    try {
      await _fireStore.add({"account": account, "balance": balance, "wallet_balance": walletBalance});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': '${e.message}'");
      }
    } 
    catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<AccountModel>> get() async {
    List<AccountModel> accList = [];

    try {
      final acc = await FirebaseFirestore.instance.collection("accounts").get();

      acc.docs.forEach((element) {
        return accList.add(AccountModel.fromJson(element.data()));
      });

      return accList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': '${e.message}'");
      }

      return accList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}