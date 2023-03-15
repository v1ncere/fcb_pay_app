import 'package:fcb_pay_app/repository/repository.dart';
import 'package:hive_flutter/adapters.dart';

abstract class BaseHiveRepository {
  Future<Box> accountBox();
  Future<List<Account>> getAccounts();
  Future<void> addAccount(Account acct);
  Future<void> putAccount(Account acct);
  Future<void> deleteAccount(Account acct);
  Future<void> clearAccounts();
}

class HiveRepository extends BaseHiveRepository {
  final String _boxName = "ACCOUNT";

  @override
  Future<Box> accountBox() async {
    Box box = await Hive.openBox<Account>(_boxName);
    return box;
  }

  @override
  Future<List<Account>> getAccounts() async {
    final Box box = await accountBox();
    return box.values.toList().cast<Account>();
  }

  @override
  Future<void> addAccount(Account acct) async {
    final Box box = await accountBox();
    await box.add(acct);
  }

  @override
  Future<void> putAccount(Account acct) async {
    final Box box = await accountBox();
    String data = acct.account.toString();
    int key = int.parse(data.substring(data.length - 6));

    await box.put(key, acct);
  }

  @override
  Future<void> deleteAccount(Account acct) async {
    final Box box = await accountBox();
    String data = acct.account.toString();
    int key = int.parse(data.substring(data.length - 6));

    await box.delete(key);
  }

  @override
  Future<void> clearAccounts() async {
    final Box box = await accountBox();
    await box.clear();
  }
}