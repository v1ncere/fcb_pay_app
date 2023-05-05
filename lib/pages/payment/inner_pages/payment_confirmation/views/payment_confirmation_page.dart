import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';

class PaymentConfirmationPage extends StatelessWidget {
  const PaymentConfirmationPage({super.key});

  static Route<void> route() => MaterialPageRoute<String>(builder: (context) => const PaymentConfirmationPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HiveRepository(),
      child: BlocProvider(
        create: (context) => PaymentConfirmationBloc(hiveRepository: HiveRepository())
        ..add(PaymentConfirmationLoaded()),
        child: const SafeArea(
          child: PaymentConfirmationView()
        ),
      )
    );
  }
}