import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fcb_pay_app/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp();
  await Hive.initFlutter();

  final firebaseAuthRepository = FirebaseAuthRepository();
  await firebaseAuthRepository.user.first;
  
  runApp(App(firebaseAuthRepository: firebaseAuthRepository));
}