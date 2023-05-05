import 'package:fcb_pay_app/pages/payment/bloc/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: const SafeArea(
        child: PaymentView(),
      ),
    );
  }
}