import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/pages/scanner/scanner.dart';

class ScannerTransactionPage extends StatelessWidget {
  const ScannerTransactionPage({super.key});

   static Page<void> page() => const MaterialPage<void>(child: ScannerTransactionPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HiveRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ScannerTransactionBloc()),
          BlocProvider(create: (context) => ScannerDisplayBloc(hiveRepository: HiveRepository())..add(ScannerDisplayLoaded())),
        ],
        child: const ScannerTransactionView(),
      ),
    );
  }
}