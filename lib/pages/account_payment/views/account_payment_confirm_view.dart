import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/pages/payment/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class AccountPaymentConfirmView extends StatelessWidget {
  const AccountPaymentConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if(state.status.isSuccess) {
          context.flow<AppStatus>().update((next) => AppStatus.account);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            "Payment sent!",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white
          ));
        }
        if(state.status.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            state.error,
            FontAwesomeIcons.triangleExclamation,
            Colors.red
          ));
        }
      },
      builder: (context, state) {
        return BlocSelector<AppBloc, AppState, String>(
          selector: (appState) => appState.args,
          builder: (_, account) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConfirmDisplayCard(
                      account: account,
                      additional: state.additional,
                      amount: state.amount.value,
                      institution: state.institutionDropdown.value ?? "",
                      controllers: state.controllers,
                    ),
                    const SizedBox(height: 120),
                    Column(
                      children: [
                        const Divider(thickness: 2),
                        const CustomizedText(
                          text: "Please verify your data for accuracy and completeness before proceeding with the payment.",
                          fontSize: 12,
                          color: Colors.black54
                        ),
                        const SizedBox(height: 20),
                        SubmitButton(account: account),
                        const StepperCancelButton()
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
    ); 
  }
}