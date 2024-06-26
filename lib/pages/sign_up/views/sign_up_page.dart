import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:firebase_storage_repository/firebase_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';

class SignupRoute extends StatelessWidget {
  const SignupRoute({super.key});
  static Route<void> route() => MaterialPageRoute(builder: (_) => const SignupRoute());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lightThemeData(context),
      debugShowCheckedModeBanner: false,
      home: const SignUpPage(),
      builder: EasyLoading.init(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static Page<void> page() => const MaterialPage(child: SignUpPage());
  static final _firebaseDatabaseRepository = FirebaseRealtimeDBRepository();
  static final _firebaseAuthRepository = FirebaseAuthRepository();
  static final _firebaseStorageRepository = FirebaseStorageRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _firebaseDatabaseRepository),
        RepositoryProvider(create: (context) => _firebaseAuthRepository),
        RepositoryProvider(create: (context) => _firebaseStorageRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignUpBloc(
            firebaseDatabaseRepository: _firebaseDatabaseRepository,
            firebaseAuthRepository: _firebaseAuthRepository,
            firebaseStorageRepository: _firebaseStorageRepository
          )..add(LostDataRetrieved())),
          BlocProvider(create: (context) => SignUpStepperCubit(length: 4)), // length starts at 1
        ],
        child: const SignUpView()
      )
    );
  }
}
