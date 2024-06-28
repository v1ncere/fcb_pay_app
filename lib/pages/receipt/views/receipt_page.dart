import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../receipt.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: ReceiptPage());
  static final _hiveRepository = HiveRepository();
  static final _firebaseDatabase = FirebaseRealtimeDBRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _hiveRepository),
        RepositoryProvider(create: (context) => _firebaseDatabase)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ReceiptBloc(
              hiveRepository: _hiveRepository,
              firebaseRepository: _firebaseDatabase
            )..add(ReceiptDisplayLoaded()),
          ),
          BlocProvider(create: (context) => SaveReceiptCubit())
        ],
        child: const ReceiptView()
      )
    );
  }
}