import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/pages/home/home.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: PaymentPage());

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => HiveRepository()),
        RepositoryProvider(create: (context) => FirebaseRealtimeDBRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PaymentStepperCubit(stepLength: 3)),
          BlocProvider(create: (context) => PaymentBloc(
            firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository(),
            hiveRepository: HiveRepository()
          )),
          BlocProvider(
            create: (context) => InstitutionDisplayBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository())
            ..add(InstitutionDisplayLoaded())
          ),
          BlocProvider(
            create: (context) => AccountDisplayBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository())
            ..add(AccountDisplayLoaded())
          )
        ],
        child: const PaymentStepperView()
      )
    );
  }
}