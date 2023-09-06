import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/pages/payment/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w700
            )
          )
        ),
        body: BlocListener<PaymentBloc, PaymentState>(
          listenWhen: (previous, current) => previous.formzStatus != current.formzStatus,
          listener: (context, state) {
            if(state.formzStatus.isSuccess) {
              context.flow<AppStatus>().update((next) => AppStatus.paymentReceipt);
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar("Payment sent!", FontAwesomeIcons.solidCircleCheck, Colors.white));
            }
            if(state.formzStatus.isFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar(state.message, FontAwesomeIcons.triangleExclamation, Colors.red));
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
                      CustomText(text: 'Select Institution', fontSize: 14, color: Color(0xFF25C166)),
                      SizedBox(height: 2),
                      InstitutionDropdown(),
                      SizedBox(height: 8),
                      // additional specific widgets
                      AdditionalWidgets(),
                    ]
                  ),
                  SizedBox(height: 10),
                  CustomCardContainer(
                    color: Colors.white,
                    children: [
                      // select account
                      CustomText(text: 'Select Account', fontSize: 14, color: Color(0xFF25C166)),
                      SizedBox(height: 2),
                      AccountDropdown(),
                      SizedBox(height: 8),
                      // input amount
                      Divider(thickness: 2), // line divider -----------------
                      CustomText(text: "Payment Amount", color: Color(0xFF25C166)),
                      SizedBox(height: 2),
                      PaymentAmountTextField(),
                    ]
                  ),
                  SizedBox(height: 10), 
                  Divider(thickness: 2), // line divider ---------------------
                  SizedBox(height: 5),
                  Column(
                    children: [
                      CustomText(text: "Please verify your data for accuracy and completeness before proceeding with the payment.",
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