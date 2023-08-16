import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account_fund_transfer/account_fund_transfer.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';

class AccountFundTransferPage extends StatelessWidget {
  const AccountFundTransferPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: AccountFundTransferPage());

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) => state.args,
      builder: (context, args) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => FirebaseRealtimeDBRepository()),
            RepositoryProvider(create: (context) => HiveRepository())
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => FundTransferAccountBloc(
                  firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
                )..add(FundTransferAccountLoaded())
              ),
              BlocProvider(
                create: (context) => FundTransferBloc(
                  firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository(),
                  hiveRepository: HiveRepository()
                )..add(SourceAccountChanged(args))
              ),
              BlocProvider(create: (context) => FundTransferStepperCubit(stepLength: 3))
            ],
            child: const AccountFundTransferStepperView()
          )
        );
      }
    );
  }
}