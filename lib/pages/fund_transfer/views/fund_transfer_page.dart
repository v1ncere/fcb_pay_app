import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/home/home.dart';

class FundTransferPage extends StatelessWidget {
  const FundTransferPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: FundTransferPage());

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => FirebaseRealtimeDBRepository()),
        RepositoryProvider(create: (context) => HiveRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AccountDisplayBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository())
            ..add(AccountDisplayLoaded())
          ),
          BlocProvider(
            create: (context) => FundTransferAccountBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository())
            ..add(FundTransferAccountLoaded())
          ),
          BlocProvider(create: (context) => FundTransferBloc(
            firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository(),
            hiveRepository: HiveRepository()
          )),
          BlocProvider(create: (context) => FundTransferStepperCubit(stepLength: 3))
        ],
        child: const FundTransferStepperView()
      )
    );
  }
}