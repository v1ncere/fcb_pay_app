import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: AccountSettingsPage());
  static final _firebaseRepository = FirebaseRealtimeDBRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _firebaseRepository,
      child: BlocProvider(
        create: (context) => AccountSettingsBloc(firebaseRepository: _firebaseRepository),
        child: const AccountSettingsView()
      )
    );
  }
}