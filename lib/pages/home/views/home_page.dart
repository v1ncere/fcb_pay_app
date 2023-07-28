import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomePage());
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SliderCubit(),
      child: const HomeView()
    );
  }
}