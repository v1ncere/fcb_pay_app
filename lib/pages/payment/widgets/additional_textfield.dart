import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';

class AdditionalTextField extends StatelessWidget {
  const AdditionalTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              state.controllers.isNotEmpty ? _description() : const SizedBox.shrink(),
              _listView(state),
            ]
          )
        );
      }
    );
  }

  Widget _description() {
    return const Row(
      children: [
        Text("additional fields",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w700
          )
        )
      ]
    );
  }

  Widget _listView(PaymentState state) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 5),
      shrinkWrap: true,
      itemCount: state.fields.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: state.fields[index]
        );
      }
    );
  }
}