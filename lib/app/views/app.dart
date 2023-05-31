import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/utils/theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required FirebaseAuthRepository firebaseAuthRepository,
  }) : _firebaseAuthRepository = firebaseAuthRepository;
  final FirebaseAuthRepository _firebaseAuthRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _firebaseAuthRepository,
      child: BlocProvider(
        create: (_) => AppBloc(firebaseAuthRepository: _firebaseAuthRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterTheme(context: context).light,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
