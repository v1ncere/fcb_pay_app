import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_home/bottom_appbar_home.dart';

class BottomAppbarPage extends StatelessWidget {
  const BottomAppbarPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: BottomAppbarPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseRealtimeDBRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BottomAppbarCubit()),
          BlocProvider(create: (context) => HomeDisplayBloc(firebaseDatabaseService: FirebaseRealtimeDBRepository()
          )..add(HomeDisplayLoaded()))
        ],
        child: const HomeBottomAppbarView()
      )
    );
  }
}