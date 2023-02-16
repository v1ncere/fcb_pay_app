import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/repository/repository.dart';
import 'package:fcb_pay_app/ui/home_card_buttons/home_card_buttons.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AccountHiveRepository(),
      child: BlocProvider(
        create: (context) => AccountsBloc(AccountHiveRepository())..add(AccountInitialEvent()),
        child: const DeleteAccountForm(),
      ),
    );
  }
} 