import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/account.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: AccountPage());

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) => state.args,
      builder: (_, args) {
        return RepositoryProvider(
          create: (context) => FirebaseRealtimeDBRepository(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => TransactionFilterBloc(
                firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
              )..add(TransactionFilterLoaded())),
              BlocProvider(create: (context) => TransactionHistoryBloc(
                firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
              )..add(TransactionHistoryLoaded(account: args)))
            ],
            child: const AccountView()
          )
        );
      }
    );
  }
}