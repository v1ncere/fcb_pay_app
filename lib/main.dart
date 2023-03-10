import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  await Hive.initFlutter();
  final dbDirectory = await getApplicationSupportDirectory();
  Hive.init(dbDirectory.path);
  Hive.registerAdapter(AccountAdapter());
  final accountHiveRepository = HiveRepository();
  await accountHiveRepository.accountBox();
  
  runApp(const App());
}