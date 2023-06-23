import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_home/bottom_appbar_home.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_payment/bottom_appbar_payment.dart';

class BottomAppbarPaymentPage extends StatelessWidget {
  const BottomAppbarPaymentPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: BottomAppbarPaymentPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseRealtimeDBRepository,  
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PaymentStepperCubit(stepLength: 2)),
          BlocProvider(create: (context) => PaymentBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository())),
          BlocProvider(create: (context) => InstitutionDisplayBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
          )..add(InstitutionDisplayLoaded())),
          BlocProvider(create: (context) => HomeDisplayBloc(firebaseDatabaseService: FirebaseRealtimeDBRepository()
          )..add(HomeDisplayLoaded()))
        ],
        child: const BottomAppbarPaymentStepper(),
      )
    );
  }
}