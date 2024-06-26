import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../home/home.dart';
import '../../payments/payments.dart';
import '../../transfers/transfers.dart';
import '../bottom_navbar.dart';

class BottomNavbarPage extends StatelessWidget {
  const BottomNavbarPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: BottomNavbarPage()); // under this nav dont create another .page()
  static final _firebaseRepository = FirebaseRealtimeDBRepository();
  static final _hiveRepository = HiveRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _firebaseRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BottomNavbarCubit()),
          BlocProvider(create: (context) => InactivityCubit()..resetTimer()),
          BlocProvider(create: (context) => PaymentButtonsBloc(firebaseRealtimeDBRepository: _firebaseRepository)
          ..add(PaymentButtonsLoaded())),
          BlocProvider(create: (context) => TransferButtonsBloc(firebaseRealtimeDBRepository: _firebaseRepository)
          ..add(TransferButtonsLoaded())),
          BlocProvider(create: (context) => AccountsHomeBloc(firebaseRealtimeDBRepository: _firebaseRepository, hiveRepository: _hiveRepository)
          ..add(UserDetailsStreamed())
          ..add(AccountsHomeLoaded()))
        ],
        child: const BottomNavbarView()
      )
    );
  }
}