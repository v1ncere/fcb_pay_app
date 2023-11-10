import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/pin/pin.dart';

class AuthPinView extends StatelessWidget {
  const AuthPinView({super.key});

  static const String setupPin = "Setup PIN";
  static const String createPin = "Create PIN";
  static const String authenticationSuccess = "Login Success";
  static const String authenticationFailure = "Login Failed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextButton(
                child: const Text(createPin, style: TextStyle(color: Color(0xFF687ea1))),
                onPressed: () => context.flow<AppStatus>().update((next) => AppStatus.createPin),
              )
            )
          )
        ]
      ),
      body: BlocListener<AuthPinBloc, AuthPinState>(
        listener: (context, state) {
          if (state.pinStatus == AuthPinStatus.equals) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => const AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                title: Center(child: Text(authenticationSuccess)),
                actionsAlignment: MainAxisAlignment.center,
              ),
            );
          }
          if (state.pinStatus == AuthPinStatus.unequals) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) =>  AlertDialog(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                title: const Center(child: Text(authenticationFailure)),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK')
                  )
                ]
              )
            );
          }
        },
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Expanded(flex: 1, child: PhoneNumber()),
            Expanded(flex: 2, child: AuthInputPinWidget()),
            Expanded(flex: 3, child: AuthNumPad()),
          ]
        )
      )
    );
  }
}