import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../utils/utils.dart';
import '../app.dart';

class App extends StatelessWidget {
  const App({super.key});
  static Route<AppStatus> route() => MaterialPageRoute(builder: (_) => const App());
  static final _firebaseAuth = FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _firebaseAuth,
      child: BlocProvider(
        create: (context) => AppBloc(firebaseAuthRepository: _firebaseAuth),
        child: const AppView()
      )
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lightThemeData(context),
      // themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGeneratePages,
      ),
      builder: EasyLoading.init(),
    );
  }
}
