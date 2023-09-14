import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/fund_transfer/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class FundTransferView extends StatelessWidget {
  const FundTransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fund Transfer',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w700
            )
          )
        ),
        body: BlocListener<FundTransferBloc, FundTransferState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if(state.status.isSuccess) {
              context.flow<AppStatus>().update((next) => AppStatus.fundTransferReceipt);
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar("Fund Transfer Request Successful!", FontAwesomeIcons.solidCircleCheck, Colors.white));
            }
            if(state.status.isFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar(state.error, FontAwesomeIcons.triangleExclamation, Colors.red));
            }
          },
          child:  (
            const SingleChildScrollView(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  CustomCardContainer(
                    color: Colors.white,
                    children: [
                      // select institution
                      CustomText(text: 'Recipient', fontSize: 14, color: Color(0xFF25C166)),
                      SizedBox(height: 2),
                      RecipientDropdown()
                    ]
                  ),
                  SizedBox(height: 10),
                  CustomCardContainer(
                    color: Colors.white,
                    children: [
                      // select account
                      CustomText(text: 'Source', fontSize: 14, color: Color(0xFF25C166)),
                      SizedBox(height: 2),
                      SourceDropdown(),
                      SizedBox(height: 8),
                      // input amount
                      Divider(thickness: 2), // line divider -----------------
                      CustomText(text: "Amount", color: Color(0xFF25C166)),
                      SizedBox(height: 2),
                      AmountTextField(),
                      SizedBox(height: 8),
                      CustomText(text: "Message (optional):", color: Color(0xFF25C166)),
                      SizedBox(height: 2),
                      MessageTextField(),
                    ]
                  ),
                  SizedBox(height: 10), 
                  Divider(thickness: 2), // line divider ---------------------
                  SizedBox(height: 5),
                  Column(
                    children: [
                      CustomText(text: "Please verify your data for accuracy and completeness before proceeding with the transfer.",
                        fontSize: 12,
                        color: Colors.teal
                      ),
                      SizedBox(height: 20),
                      SubmitButton(),
                      CancelButton(),
                    ]
                  ),
                  SizedBox(height: 10)
                ]
              )
            )
          )
        )
      )
    );
  }
}