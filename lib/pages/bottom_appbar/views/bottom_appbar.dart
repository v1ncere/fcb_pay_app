import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/home/home.dart';
import 'package:fcb_pay_app/repository/repository.dart';

class BottomAppbar extends StatelessWidget {
  const BottomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) { 
        FirebaseFirestoreRepository(); 
        HiveRepository();
        FirebaseDatabaseRepository();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => BottomAppbarCubit()),
          BlocProvider(create: (context) => FirebaseFirestoreRepositoryBloc(
            firebaseFirestoreRepository: FirebaseFirestoreRepository(),
            hiveRepository: HiveRepository(),
          )..add(LoadAccounts())),
          BlocProvider(create: (context) => AccountCubit(accountHiveRepository: HiveRepository())),
        ],
        child: const HomeBottomAppbarWidget(),
      ),
    );
  }
}