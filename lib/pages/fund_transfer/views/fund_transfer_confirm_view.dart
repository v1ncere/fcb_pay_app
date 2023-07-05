import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/fund_transfer/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class FundTransferConfirmView extends StatelessWidget {
  const FundTransferConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FundTransferBloc, FundTransferState>(
      listener: (context, state) {
        if(state.status.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            state.error,
            FontAwesomeIcons.triangleExclamation,
            Colors.red
          ));
        }
        if(state.status.isSuccess) {
          context.flow<AppStatus>().update((next) => AppStatus.authenticated);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            "Fund Transfer Request Sent!",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white
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
                  source: state.sourceDropdown.value ?? '',
                  recipient: state.recipientDropdown.value ?? '',
                  amount: state.amount.value,
                  message: state.message.value
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