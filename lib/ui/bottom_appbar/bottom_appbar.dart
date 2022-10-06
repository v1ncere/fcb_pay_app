import 'package:fcb_pay_app/db/account_repository.dart';
import 'package:fcb_pay_app/ui/bottom_appbar/cubit/bottom_appbar_cubit.dart';
import 'package:fcb_pay_app/ui/bottom_appbar/widgets/bottom_appbar_widget.dart';
import 'package:fcb_pay_app/ui/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomAppbar extends StatelessWidget {
  const BottomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(accountRepository: RepositoryProvider.of<AccountRepository>(context)),
        ),
        BlocProvider(
          create: (context) => BottomAppbarCubit(),
        )
      ],
      child: const HomeBottomAppbarWidget(),
    );
  }
}