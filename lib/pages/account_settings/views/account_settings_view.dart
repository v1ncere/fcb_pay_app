import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';
import 'package:fcb_pay_app/pages/account_settings/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AccountSettingsBloc, AccountSettingsState>(
          listener: (context, state) {
            Timer? timer;
            if(state.status.isSuccess) {
              showDialog(
                context: context,
                builder: (ctx) {
                  timer = Timer(const Duration(milliseconds: 2000), () {
                    Navigator.of(ctx).pop(true);
                  });
                  return const AnimationDialog(icon: FontAwesomeIcons.check, color: Colors.green);
                }
              ).then((_) {
                timer?.cancel();
              });
            }
            if (state.status.isError) {
              showDialog(
                context: context,
                builder: (ctx) {
                  timer = Timer(const Duration(milliseconds: 2000), () {
                    Navigator.of(ctx).pop(true);
                  });
                  return const AnimationDialog(icon: FontAwesomeIcons.xmark, color: Colors.red);
                }
              ).then((_) {
                timer?.cancel();
              });
            }
          },
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: HeadersCard(),
              ),
              ContainerBody(
                children: [
                  AddAccountButton(),
                  AccountListViewDisplay()
                ]
              )
            ]
          ),
        )
      ),
    );
  }
}
