import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';

import 'package:fcb_pay_app/pages/pin/pin.dart';

class AuthPinPage extends StatelessWidget {
  const AuthPinPage({super.key});

  static const String setupPIN = "Setup PIN";
  static const String createPIN = "Create PIN";
  static const String authenticationSuccess = "Login Success";
  static const String authenticationFailed = "Login Failed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextButton(
                child: const Text(createPIN, style: TextStyle(color: Color(0xFF687ea1))),
                onPressed: () => Navigator.pushNamed(context, '/create_pin'),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          lazy: false,
          create: (_) => AuthPinBloc(hivePinRepository: HivePinRepository()),
          child: BlocListener<AuthPinBloc, AuthPinState>(
            listener: (context, state) {
              if (state.pinStatus == AuthPinStatus.equals) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: Center(child: Text(authenticationSuccess)),
                    actionsAlignment: MainAxisAlignment.center,
                  ),
                );
                Future.delayed(const Duration(milliseconds: 1000), () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false));
              } else if (state.pinStatus == AuthPinStatus.unequals) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>  AlertDialog(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: const Center(child: Text(authenticationFailed)),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'))
                    ],
                  )
                );
              }
            },
            child: const Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: 1, child: PhoneNumber()),
                Expanded(flex: 2, child: AuthInputPinWidget()),
                Expanded(flex: 3, child: AuthNumPad()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
