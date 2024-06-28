import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../home_flow/home_flow.dart';
import '../widgets/widgets.dart';

class ScannerTransactionView extends StatelessWidget {
  const ScannerTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InactivityDetector(
        onInactive: () => context.flow<HomeRouterStatus>().complete(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Transaction',
              style: TextStyle(
                color: ColorString.jewel,
                fontWeight: FontWeight.w700
              )
            ),
            actions: [
              IconButton(
                onPressed: () => context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.appBar),
                icon: const Icon(FontAwesomeIcons.x, size: 18)
              )
            ]
          ),
          body: const Padding(
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QrDataDisplay(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(text: 'Account:', color: Colors.black54)
                    ]
                  ),
                  SizedBox(height: 5),
                  AccountDropdown(),
                  SizedBox(height: 10),
                  AccountCardInfo(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(text: 'Amount:', color: Colors.black54),
                    ]
                  ),
                  SizedBox(height: 5),
                  AmountInput(),
                  SizedBox(height: 10), 
                  Divider(thickness: 2), // line divider ---------------------
                  SizedBox(height: 5),
                  CustomText(text: 'Please verify your data for accuracy and completeness before proceeding with the payment.',
                    fontSize: 12,
                    color: Colors.teal
                  ),
                  SizedBox(height: 15),
                  SubmitButton(),
                  SizedBox(height: 20)
                ]
              )
            )
          )
        ),
      )
    );
  }
}