import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

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
        : CustomElevatedButton(
          buttonColor: const Color(0xFF25C166),
          title: 'Pay',
          titleColor: Colors.white,
          icon: FontAwesomeIcons.coins,
          iconColor: Colors.white,
          onPressed: state.isValid
          ? () => context.read<PaymentBloc>().add(PaymentSubmitted(account ?? ''))
          : null,
        );
      }
    );
  }
}