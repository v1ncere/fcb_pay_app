import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  static Route<void> route() => MaterialPageRoute<String>(builder: (context) => const PaymentPage());

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => HiveRepository()),
        RepositoryProvider(create: (context) => FirebaseRealtimeDBRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PaymentBloc()),
          BlocProvider(create: (context) => DisplayPaymentDataBloc(
            hiveRepository: HiveRepository()
          )..add(DisplayPaymentDataLoaded())),
          BlocProvider(create: (context) => PaymentStepperCubit(stepLength: 2)),
        ],
        child: const SafeArea(child: PaymentStepperView()),
      )
    );
  }
}