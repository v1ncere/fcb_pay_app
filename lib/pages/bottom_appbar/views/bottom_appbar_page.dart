import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';

class BottomAppbarPage extends StatelessWidget {
  const BottomAppbarPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: BottomAppbarPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomAppbarCubit(),
      child: const HomeBottomAppbarView(),
    );
  }
}