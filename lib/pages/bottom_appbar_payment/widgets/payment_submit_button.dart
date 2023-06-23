import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_payment/bottom_appbar_payment.dart';

class PaymentSubmitButton extends StatelessWidget {
  const PaymentSubmitButton({super.key, required this.account});
  final String account;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (previous, current) => previous.status != current.status || current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
        ? const CircularProgressIndicator()
        : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRect(
              child: Material(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF009405),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.white38,
                  // onTap: state.isValid
                  //   ? () => context.read<PaymentBloc>().add(const PaymentSubmitted(""))
                  //   : null,
                  onTap: () => context.read<PaymentBloc>().add(PaymentSubmitted(account)),
                  child: const SizedBox(
                    height: 45,
                    width: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('PAY',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          FontAwesomeIcons.coins, 
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}