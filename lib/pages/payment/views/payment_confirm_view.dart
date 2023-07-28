import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/pages/payment/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class PaymentConfirmView extends StatelessWidget {
  const PaymentConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess) {
          context.flow<AppStatus>().update((next) => AppStatus.authenticated);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            "Payment sent!",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white
          ));
        }
        if(state.formStatus.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            state.message,
            FontAwesomeIcons.triangleExclamation,
            Colors.red
          ));
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConfirmDisplayCard(
                  account: state.accountDropdown.value ?? "",
                  additional: state.additional,
                  amount: state.amount.value,
                  institution: state.institutionDropdown.value ?? "",
                  isInputted: context.read<PaymentBloc>().hasUserInputInTextFields(),
                ),
                const SizedBox(height: 120),
                const Column(
                  children: [
                    Divider(thickness: 2),
                    CustomizedText(
                      text: "Please verify your data for accuracy and completeness before proceeding with the payment.",
                      fontSize: 12,
                      color: Colors.black54
                    ),
                    SizedBox(height: 20),
                    SubmitButton(account: ''),
                    StepperCancelButton()
                  ]
                ),
                const SizedBox(height: 20) // for visible bottom
              ]
            )
          )
        );
      }
    );
  }
}