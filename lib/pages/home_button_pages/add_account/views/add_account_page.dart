import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home_button_pages/home_button_pages.dart';
import 'package:fcb_pay_app/repository/repository.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseDatabaseService(),
      child: BlocProvider(
        create: (context) => AddAccountBloc(firebaseDatabaseService: FirebaseDatabaseService()),
        child: const AddAccountForm(),
      ),
    );
  }
}