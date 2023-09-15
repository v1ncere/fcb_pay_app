import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';

class HomeDynamicPage extends StatelessWidget {
  const HomeDynamicPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomeDynamicPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseRealtimeDBRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SliderCubit()), // for the slider below the carousel
          BlocProvider(
            create: (context) => ButtonsBloc(
              firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
            )..add(ButtonsLoaded())
          )
        ],
        child: const HomeDynamicView()
      )
    );
  }
}