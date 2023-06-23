import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_payment/bottom_appbar_payment.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class PaymentSubmissionView extends StatelessWidget {
  const PaymentSubmissionView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocListener<PaymentBloc, PaymentState>(
        listenWhen: (previous, current) => previous.status != current.status,
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
              Colors.red
            ));
          }
        },
        child: Column(
          children: [
            const PaymentAmountInput(),
            const SizedBox(height: 15),
            const AdditionalTextField(),
            const SizedBox(height: 20),
            BlocSelector<AppBloc, AppState, String>(
              selector: (state) => state.args,
              builder: (context, args) {
                return PaymentSubmitButton(account: args);
              },
            ),
          ],
        ),
      )
    );
  }
}