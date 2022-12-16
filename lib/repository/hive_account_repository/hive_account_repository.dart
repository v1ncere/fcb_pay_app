import 'package:hive_flutter/adapters.dart';

import 'package:fcb_pay_app/repository/model/account.dart';

class HiveAccountRepository {
  String boxName = "Accounts";

  Future<Box> initializeBox() async {
    Box box = await Hive.openBox<Account>(boxName);
    return box;
  }

  List<Account> getAccounts(Box box) {
    return box.values.toList().cast<Account>();
  }

  Future<void> addAccount(Box box, Account hiveAccount) async {
    await box.add(hiveAccount);
  }

  Future<void> updateAccount(Box box, Account hiveAccount) async {
    await box.put(hiveAccount.userID, hiveAccount);
  }

  Future<void> deleteAccount(Box box, Account hiveAccount) async {
    await box.delete(hiveAccount.userID);
  }

  Future<void> deleteAllAccounts(Box box) async {
    await box.clear();
  }
}