import 'package:fcb_pay_app/ui/home/cubit/bottom_navigation_cubit.dart';
import 'package:fcb_pay_app/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: const HomeScreen(),
    );
  }
}