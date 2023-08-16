import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_nav/bottom_appbar_nav.dart';
import 'package:fcb_pay_app/pages/home/home.dart';

class BottomAppbarNavPage extends StatelessWidget {
  const BottomAppbarNavPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: BottomAppbarNavPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseRealtimeDBRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BottomAppbarNavCubit()),
          BlocProvider(create: (context) => AccountDisplayBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
          )..add(AccountDisplayLoaded()))
        ],
        child: const BottomAppbarNavView()
      )
    );
  }
}