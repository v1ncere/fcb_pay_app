import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../account_add.dart';

class AccountAddPage extends StatelessWidget {
  const AccountAddPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: AccountAddPage());
  static final _firebaseRepository = FirebaseRealtimeDBRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _firebaseRepository,
      child: BlocProvider(
        create: (context) => AccountAddBloc(firebaseDatabase: _firebaseRepository),
        child: const AccountAddView()
      )
    );
  }
}