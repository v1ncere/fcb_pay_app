import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, this.account});
  final String? account;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (previous, current) => previous.formzStatus != current.formzStatus || current.isValid,
      builder: (context, state) {
        return state.formzStatus.isInProgress
        ? const CircularProgressIndicator()
        : ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            elevation: MaterialStateProperty.all(2),
            backgroundColor: MaterialStateProperty.all(const Color(0xFF25C166)) 
          ),
          onPressed: state.isValid
          ? () => context.read<PaymentBloc>().add(PaymentSubmitted(account ?? ''))
          : null,
          child: const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pay',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  )
                ),
                SizedBox(width: 5),
                Icon(
                  FontAwesomeIcons.coins,
                  color: Colors.white,
                  size: 20
                )
              ]
            )
          )
        );
      }
    );
  }
}