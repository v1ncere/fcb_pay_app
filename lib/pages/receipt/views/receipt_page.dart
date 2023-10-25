import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/pages/receipt/receipt.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: ReceiptPage());

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => HiveRepository()),
        RepositoryProvider(create: (context) => FirebaseRealtimeDBRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ReceiptBloc(
              hiveRepository: HiveRepository(),
              firebaseRepository: FirebaseRealtimeDBRepository()
            )..add(ReceiptDisplayLoaded()),
          ),
          BlocProvider(create: (context) => SaveReceiptCubit())
        ],
        child: const ReceiptView()
      )
    );
  }
}