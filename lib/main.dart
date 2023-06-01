import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fcb_pay_app/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final firebaseAuthRepository = FirebaseAuthRepository();
  await firebaseAuthRepository.user.first;

  await Hive.initFlutter();
  await Hive.openBox('scannerBox');

  Bloc.observer = const AppBlocObserver();
  
  runApp(
    RepositoryProvider.value(
      value: firebaseAuthRepository,
      child: BlocProvider(
        create: (context) => AppBloc(firebaseAuthRepository: firebaseAuthRepository),
        child: const App(),
      ),
    )
  );
}