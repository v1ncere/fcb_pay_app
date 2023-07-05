import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_home/bottom_appbar_home.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';

class FundTransferPage extends StatelessWidget {
  const FundTransferPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: FundTransferPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseRealtimeDBRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeDisplayBloc(firebaseDatabaseService: FirebaseRealtimeDBRepository()
          )..add(HomeDisplayLoaded())),
          BlocProvider(create: (context) => FundTransferAccountBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
          )..add(FundTransferAccountLoaded())),
          BlocProvider(create: (context) => FundTransferBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository())),
          BlocProvider(create: (context) => FundTransferStepperCubit(stepLength: 3))
        ],
        child: const FundTransferStepperView()
      )
    );
  }
}