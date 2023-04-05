import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:hive_flutter/adapters.dart';

abstract class BaseHiveAccountService {
  Future<Box> accountBox();
  Future<List<User>> getAccounts();
  Future<void> addAccount(User acct);
  Future<void> putAccount(User acct);
  Future<void> deleteAccount(User acct);
  Future<void> clearAccounts();
}

class HiveAccountService extends BaseHiveAccountService {
  final String _boxName = "ACCOUNT";

  @override
  Future<Box> accountBox() async {
    Box box = await Hive.openBox<User>(_boxName);
    return box;
  }

  @override
  Future<List<User>> getAccounts() async {
    final Box box = await accountBox();
    return box.values.toList().cast<User>();
  }

  @override
  Future<void> addAccount(User acct) async {
    final Box box = await accountBox();
    await box.add(acct);
  }

  @override
  Future<void> putAccount(User acct) async {
    final Box box = await accountBox();
    String data = acct.email.toString();
    int key = int.parse(data.substring(data.length - 6));

    await box.put(key, acct);
  }

  @override
  Future<void> deleteAccount(User acct) async {
    final Box box = await accountBox();
    String data = acct.email.toString();
    int key = int.parse(data.substring(data.length - 6));

    await box.delete(key);
  }

  @override
  Future<void> clearAccounts() async {
    final Box box = await accountBox();
    await box.clear();
  }
}