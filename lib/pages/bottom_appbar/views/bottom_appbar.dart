import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/repository/repository.dart';

class BottomAppbar extends StatelessWidget {
  const BottomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HiveAccountService(),
      child: BlocProvider(
        create: (context) => BottomAppbarCubit(),
        child: const HomeBottomAppbarView(),
      ),
    );
  }
}