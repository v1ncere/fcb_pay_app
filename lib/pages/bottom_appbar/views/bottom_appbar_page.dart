import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/home_display/home_display.dart';
import 'package:fcb_pay_app/pages/transaction_history/bloc/transaction_history_bloc.dart';

class BottomAppbarPage extends StatelessWidget {
  const BottomAppbarPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: BottomAppbarPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseRealtimeDBRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeDisplayBloc(
            firebaseDatabaseService: FirebaseRealtimeDBRepository(),
          )..add(HomeDisplayLoaded())),
          BlocProvider(create: (context) => TransactionHistoryBloc(
            firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository(),
            )..add(TransactionHistoryLoaded())),
          BlocProvider(create: (context) => PaymentSelectionDropdownBloc(
            firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
          )..add(PaymentInstitutionLoaded())),
          BlocProvider(create: (context) => BottomAppbarCubit()),
        ],
        child: const HomeBottomAppbarView(),
    ),
    
    );
  }
}