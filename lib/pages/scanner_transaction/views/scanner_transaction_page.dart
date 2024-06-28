import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../home/home.dart';
import '../scanner_transaction.dart';

class ScannerTransactionPage extends StatelessWidget {
  const ScannerTransactionPage({super.key});
   static Page<void> page() => const MaterialPage<void>(child: ScannerTransactionPage());
   static final _firebaseRepository = FirebaseRealtimeDBRepository();
   static final _hiveRepository = HiveRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _firebaseRepository),
        RepositoryProvider.value(value: _hiveRepository)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AccountsHomeBloc(
            firebaseRealtimeDBRepository: _firebaseRepository,
            hiveRepository: _hiveRepository
          )..add(AccountsHomeLoaded())),
          BlocProvider(create: (context) => ScannerTransactionBloc(
            hiveRepository: _hiveRepository,
            firebaseRepository: _firebaseRepository
          )..add(ScannerTransactionDisplayLoaded()))
        ],
        child: const ScannerTransactionView()
      )
    );
  }
}