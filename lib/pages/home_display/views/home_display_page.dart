import 'package:fcb_pay_app/repository/repository.dart';
import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/home_display/home_display.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDisplayPage extends StatelessWidget {
  const HomeDisplayPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        FirebaseDatabaseService();
      },
      child: BlocProvider(
        create: (context) => HomeDisplayBloc(
          firebaseDatabaseService: FirebaseDatabaseService(),
        )..add(HomeDisplayLoaded()),
        child: const HomeDisplayView(),
      ),
    );
  }
}