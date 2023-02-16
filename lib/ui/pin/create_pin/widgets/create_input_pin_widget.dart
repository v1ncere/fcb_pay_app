import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/ui/pin/pin.dart';
import 'package:fcb_pay_app/ui/widgets/widgets.dart';

class CreateInputPinWidget extends StatelessWidget {
  const CreateInputPinWidget({super.key});
  static const String createPIN = "Create PIN";
  static const String reEnterYourPIN = "Re-enter your PIN";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePinBloc, CreatePinState>(
      buildWhen: (previous, current) => previous.firstPin != current.firstPin || previous.secondPin != current.secondPin,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Text(state.pinStatus == PinStatus.enterFirst ? createPIN : reEnterYourPIN, style: const TextStyle(color: Color(0xFF687ea1), fontSize: 18)),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) => PinSphere(input: index < state.getCountOfPin())),
              ),
            ),
          ]
        );
      },
    );
  }
}