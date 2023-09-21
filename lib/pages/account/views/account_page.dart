import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/account.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: AccountPage());
  static final _dbRepository = FirebaseRealtimeDBRepository();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) => state.args,
      builder: (_, args) {
        return RepositoryProvider(
          create: (context) => _dbRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => TransactionHistoryBloc(firebaseRealtimeDBRepository: _dbRepository)
              ..add(TransactionHistoryLoaded(account: args))),
              BlocProvider(create: ((context) => FilterBloc(firebaseRealtimeDBRepository: _dbRepository)
              ..add(FilterFetched()))),
            ],
            child: const AccountView()
          )
        );
      }
    );
  }
}