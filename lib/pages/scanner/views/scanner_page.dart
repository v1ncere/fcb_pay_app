import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../scanner.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});
  static final _hiveRepository = HiveRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _hiveRepository,
      child: BlocProvider(
        create: (context) => ScannerCubit(hiveRepository: _hiveRepository),
        child: const ScannerView()
      )
    );
  }
}
