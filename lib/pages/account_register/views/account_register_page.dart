import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/account_register/account_register.dart';

class AccountRegisterPage extends StatelessWidget {
  const AccountRegisterPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: AccountRegisterPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseRealtimeDBRepository(),
      child: BlocProvider(
        create: (context) => AccountRegisterBloc(firebaseDatabaseService: FirebaseRealtimeDBRepository()),
        child: const AccountRegisterForm()
      )
    );
  }
}