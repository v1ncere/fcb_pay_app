import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/repository/repository.dart';
import 'package:fcb_pay_app/ui/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/ui/home/home.dart';

class BottomAppbar extends StatelessWidget {
  const BottomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) { 
        AccountRepository(); 
        AccountHiveRepository();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => BottomAppbarCubit()),
          BlocProvider(create: (context) => AccountRepositoryBloc(
            accountRepository: AccountRepository(),
            accountHiveRepository: AccountHiveRepository(),
          )..add(LoadAccounts())),
          BlocProvider(create: (context) => AccountCubit(accountHiveRepository: AccountHiveRepository())),
        ],
        child: const HomeBottomAppbarWidget(),
      ),
    );
  }
}