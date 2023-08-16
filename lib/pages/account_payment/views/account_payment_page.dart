import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account_payment/account_payment.dart';
import 'package:fcb_pay_app/pages/home/home.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';

class AccountPaymentPage extends StatelessWidget {
  const AccountPaymentPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: AccountPaymentPage());

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) => state.args,
      builder: (context, args) {
        return RepositoryProvider(
          create: (context) => FirebaseRealtimeDBRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => PaymentStepperCubit(stepLength: 3)),
              BlocProvider(create: (context) => PaymentBloc(
                hiveRepository: HiveRepository(),
                firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
              )..add(AccountValueChanged(args))),
              BlocProvider(create: (context) => InstitutionDisplayBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
              )..add(InstitutionDisplayLoaded())),
              BlocProvider(create: (context) => AccountDisplayBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
              )..add(AccountDisplayLoaded()))
            ],
            child: const AccountPaymentStepperView()
          )
        );
      }
    );
  }
}