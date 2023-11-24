import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/account/account.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/widgets/widgets.dart';
import 'package:fcb_pay_app/pages/home_flow/home_flow.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Accounts",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w700
            )
          ),
          leading: BackButton(
            onPressed: () {
              context.flow<HomePageStatus>().update((state) => HomePageStatus.appBar);
              context.read<InactivityCubit>().resumeTimer();
            }
          ),
        ),
        body: InactivityDetector(
          onInactive: () {
            context.flow<HomePageStatus>().complete();
          },
          child: const Column(
            children: [
              SizedBox(height: 10),
              ContainerBody(
                children: [
                  ActionButtonView(),
                  SizedBox(height: 20),
                  TransactionHistoryView()
                ]
              )
            ]
          ),
        )
      )
    );
  }
}