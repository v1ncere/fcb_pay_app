import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';

class PaymentConfirmationView extends StatelessWidget {
  const PaymentConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: BackButton(
          color: Colors.green,
          onPressed: () {
            context.read<PaymentConfirmationBloc>().add(PaymentConfirmationDisplayDelete());
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.green,
          ),
        ),
      ),
      body: BlocBuilder<PaymentConfirmationBloc, PaymentConfirmationState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status.isSuccess) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                state.display, 
                style: const TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                )
              ),
            );
          }
          if (state.status.isFailure) {
            return Center(
              child: Text(
                state.error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w700,
                )
              )
            );
          }
          else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}