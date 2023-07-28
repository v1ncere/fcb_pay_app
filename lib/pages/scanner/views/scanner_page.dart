import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/pages/scanner/scanner.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ScannerPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>  HiveRepository(),
      child: BlocProvider(create: (context) => ScannerCubit(hiveRepository: HiveRepository()),
        child: const ScannerView()
      )
    );
  }
}