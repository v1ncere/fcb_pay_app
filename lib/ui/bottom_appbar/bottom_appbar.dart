import 'package:fcb_pay_app/repository/account_repository/account_repo.dart';
import 'package:fcb_pay_app/repository/account_repository/bloc/account_repo_bloc.dart';
import 'package:fcb_pay_app/ui/bottom_appbar/cubit/bottom_appbar_cubit.dart';
import 'package:fcb_pay_app/ui/bottom_appbar/widgets/bottom_appbar_widget.dart';
import 'package:fcb_pay_app/ui/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomAppbar extends StatelessWidget {
  const BottomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AccountRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => BottomAppbarCubit()),
          BlocProvider(create: (context) => AccountRepoBloc(accountRepository: AccountRepository())..add(LoadAccounts())),
        ],
        child: const HomeBottomAppbarWidget(),
      ),
    );
  }
}