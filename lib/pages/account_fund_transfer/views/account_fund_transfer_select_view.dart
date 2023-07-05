import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account_fund_transfer/widgets/fund_transfer_source_text.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/fund_transfer/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class AccountFundTransferSelectView extends StatelessWidget {
  const AccountFundTransferSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FundTransferBloc, FundTransferState>(
      listenWhen: (previous, current) => previous.status != current.status || current.isNotValid,
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
          context.flow<AppStatus>().update((next) => AppStatus.account);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            "Payment sent!",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white
          ));
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomizedText(text: "Source", color: Colors.black54),
            const SizedBox(height: 5),
            const FundTransferSourceText(),
            const SizedBox(height: 30),
            const CustomizedText(text: "Recipient", color: Colors.black54),
            const SizedBox(height: 5),
            const RecipientDropdown(),
            const SizedBox(height: 5),
            const Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const StepperCancelButton(status: AppStatus.account),
                const SizedBox(width: 10),
                StepperNextButton(function: () => context.read<FundTransferStepperCubit>().stepContinued())
              ]
            )
          ]
        )
      )
    );
  }
}