import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';

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
          BlocProvider(create: (context) => AccountsBloc(firebaseRepository: FirebaseRealtimeDBRepository())
          ..add(AccountsLoaded())),
          BlocProvider(create: (context) => FundTransferAccountBloc(firebaseRepository: FirebaseRealtimeDBRepository())
          ..add(FundTransferAccountLoaded())),
          BlocProvider(create: (context) => FundTransferBloc(firebaseRepository: FirebaseRealtimeDBRepository(), hiveRepository: HiveRepository()))
        ],
        child: const FundTransferView()
      )
    );
  }
}