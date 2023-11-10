import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/account.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: AccountPage());
  static final _firebaseRepository = FirebaseRealtimeDBRepository();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, AccountModel>(
      selector: (state) => state.accountModel,
      builder: (_, model) {
        return RepositoryProvider(
          create: (context) => _firebaseRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => TransactionHistoryBloc(firebaseRepository: _firebaseRepository)
              ..add(TransactionHistoryLoaded(account: model.account))),
              BlocProvider(create: ((context) => FilterBloc(firebaseRepository: _firebaseRepository)
              ..add(FilterFetched()))),
              BlocProvider(create: ((context) => AccountButtonBloc(firebaseRepository: _firebaseRepository)
              ..add(WidgetsFetched(model.type))))
            ],
            child: const AccountView()
          )
        );
      }
    );
  }
}