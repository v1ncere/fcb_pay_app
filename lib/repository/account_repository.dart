// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcb_pay_app/repository/model/account.dart';
import 'package:flutter/foundation.dart';

class AccountRepository {
  final reference = FirebaseFirestore.instance.collection('accounts');

  // Future<void> create({required int account, required int balance, required int walletBalance}) async {
  //   try {
  //     await reference.add({"account": account, "balance": balance, "wallet_balance": walletBalance});
  //   } on FirebaseException catch (e) {
  //     if (kDebugMode) {
  //       print("Failed with error '${e.code}': '${e.message}'");
  //     }
  //   } 
  //   catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  Future<List<AccountModel>> getData() async {
    List<AccountModel> accList = [];

    try {
      await FirebaseFirestore.instance.collection('accounts').get().then((query) {
        query.docs.forEach((element) {
          return accList.add(AccountModel.fromJson(element.data()));
        });
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