import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/repository/account_repository/account_repository.dart';
import 'package:fcb_pay_app/repository/model/account.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());
  final accountRepository = AccountRepository();
  await accountRepository.initializeBox();
  
  runApp(const App());
}