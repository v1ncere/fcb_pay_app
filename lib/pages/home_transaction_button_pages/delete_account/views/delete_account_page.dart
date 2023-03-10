import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/repository/repository.dart';
import 'package:fcb_pay_app/pages/home_transaction_button_pages/home_transaction_button_pages.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HiveRepository(),
      child: BlocProvider(
        create: (context) => AccountsBloc(HiveRepository())..add(AccountInitialEvent()),
        child: const DeleteAccountForm(),
      ),
    );
  }
} 