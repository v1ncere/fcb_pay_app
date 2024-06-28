import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_flow/home_flow.dart';
import '../account.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: AccountPage());
  static final _firebaseRepository = FirebaseRealtimeDBRepository();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RouterBloc, RouterState, Account>(
      selector: (state) => state.account,
      builder: (_, account) {
        return RepositoryProvider(
          create: (context) => _firebaseRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => TransactionHistoryBloc(firebaseRepository: _firebaseRepository)
              ..add(TransactionHistoryLoaded(accountID: account.accountKeyID!))),
              BlocProvider(create: (context) => FilterBloc(firebaseRepository: _firebaseRepository)
              ..add(FilterFetched())),
              BlocProvider(create: (context) => AccountButtonBloc(firebaseRepository: _firebaseRepository)
              ..add(WidgetsFetched(account.type))),
              BlocProvider(create: (context) => AccountsBloc(firebaseRepository: _firebaseRepository)
              ..add(AccountsLoaded(account))),
              BlocProvider(create: (context) => CarouselCubit()..setAccount(account: account)),
            ],
            child: AccountView(account: account)
          )
        );
      }
    );
  }
}