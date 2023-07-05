import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_home/bottom_appbar_home.dart';

class HomeDisplayPage extends StatelessWidget {
  const HomeDisplayPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomeDisplayPage());
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SliderCubit(),
      child: const HomeDisplayView()
    );
  }
}