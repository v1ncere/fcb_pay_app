import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_payment/bottom_appbar_payment.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class BottomAppbarPaymentSubmission extends StatelessWidget {
  const BottomAppbarPaymentSubmission({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
        child: BlocListener<PaymentBloc,PaymentState>(
          listener: (context, state) {
            if(state.status.isSuccess) {
              context.flow<AppStatus>().update((next) => AppStatus.authenticated);
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar(
                "Payment sent!",
                FontAwesomeIcons.solidCircleCheck,
                Colors.white,
              ));
            }
            if(state.status.isFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar(
                state.error!,
                FontAwesomeIcons.triangleExclamation,
                Colors.red,
              ));
            }
          },
          child: const Column(
            children: [
              PaymentAmountInput(),
              SizedBox(height: 15),
              AdditionalTextField(),
              SizedBox(height: 20),
              PaymentSubmitButton(account: '')
            ],
          ),
        ),
    );
  }
}