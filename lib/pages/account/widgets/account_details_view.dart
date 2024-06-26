import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../account.dart';
import 'widgets.dart';

class AccountDetailsView extends StatelessWidget {
  const AccountDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselCubit, CarouselState>(
      builder: (context, state) {
        final category = state.account.category.toLowerCase();
        if (category == 'deposit' || category == 'wallet') {
          return ExtraDisplayDeposit(account: state.account);
        }
        if (category == 'credit') {
          return ExtraDisplayCredit(account: state.account);
        }
        else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}