import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/pages/home/home.dart';
import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';

class ScannerTransactionPage extends StatelessWidget {
  const ScannerTransactionPage({super.key});
   static Page<void> page() => const MaterialPage<void>(child: ScannerTransactionPage());

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: FirebaseRealtimeDBRepository()),
        RepositoryProvider.value(value: HiveRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AccountDisplayBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository())
            ..add(AccountDisplayLoaded())
          ),
          BlocProvider(
            create: (context) => ScannerTransactionBloc(hiveRepository: HiveRepository(), firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository())
            ..add(ScannerTransactionDisplayLoaded())
          )
        ],
        child: const ScannerTransactionView()
      )
    );
  }
}