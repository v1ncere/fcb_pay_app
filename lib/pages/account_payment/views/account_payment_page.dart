import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account_payment/account_payment.dart';
import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';

class AccountPaymentPage extends StatelessWidget {
  const AccountPaymentPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: AccountPaymentPage());
  static final _firebaseRepository = FirebaseRealtimeDBRepository();
  static final _hiveRepository = HiveRepository();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) => state.args,
      builder: (context, args) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => _firebaseRepository),
            RepositoryProvider(create: (context) => _hiveRepository),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => PaymentBloc(hiveRepository: _hiveRepository, firebaseRepository: _firebaseRepository)
              ..add(AccountValueChanged(args))),
              BlocProvider(create: (context) => InstitutionDisplayBloc(firebaseRepository: _firebaseRepository)
              ..add(InstitutionDisplayLoaded())),
              BlocProvider(create: (context) => AccountsBloc(firebaseRepository: _firebaseRepository)
              ..add(AccountsLoaded()))
            ],
            child: const AccountPaymentView()
          )
        );
      }
    );
  }
}