import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home_display/home_display.dart';

class HomeDisplayPage extends StatelessWidget {
  const HomeDisplayPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseRealtimeDBRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeDisplayBloc(
            firebaseDatabaseService: FirebaseRealtimeDBRepository(),
          )..add(HomeDisplayLoaded())),
          BlocProvider(create: (context) => SliderCubit()),
        ],
        child: const HomeDisplayView(),
      ),
      
    );
  }
}