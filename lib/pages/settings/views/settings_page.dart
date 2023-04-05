import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthRepository(),
      child: BlocProvider(
        create: (context) => AppBloc(firebaseAuthRepository: FirebaseAuthRepository()),
        child: const SettingsSelection(),
      ),
    );
  }
}