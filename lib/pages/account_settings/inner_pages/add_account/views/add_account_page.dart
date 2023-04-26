import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({super.key});

  static Route<void> route() => MaterialPageRoute<void>(builder: (context) => const AddAccountPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseRealtimeDBRepository(),
      child: BlocProvider(
        create: (context) => AddAccountBloc(firebaseDatabaseService: FirebaseRealtimeDBRepository()),
        child: const AddAccountForm(),
      ),
    );
  }
}