import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/ui/pin/authentication_pin/bloc/auth_pin_bloc.dart';
import 'package:fcb_pay_app/ui/widgets/pin_sphere.dart';

class MainPart extends StatelessWidget {
  const MainPart({super.key});
  static const String enterYourPIN = "Please enter your PIN";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthPinBloc, AuthPinState>(
      buildWhen: (previous, current) => previous.pin != current.pin,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              flex: 1,
              child: Text(enterYourPIN, style: TextStyle(color: Color(0xFF687ea1), fontSize: 18)),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) => PinSphere(input: index < state.getCountsOfPIN())),
              ),
            ),
          ]
        );
      },
    );
  }
}