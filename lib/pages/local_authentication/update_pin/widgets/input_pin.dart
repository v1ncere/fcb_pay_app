import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../local_authentication.dart';

class InputPin extends StatelessWidget {
  const InputPin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePinBloc, UpdatePinState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Text(getInputTitle(state.status),
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF687ea1),
                  fontWeight: FontWeight.w700
                )
              )
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) => PinSphere(input: index < state.getPinLength()))
              )
            )
          ]
        );
      }
    );
  }
}

String getInputTitle(UpdatePinStatus status) {
  if(status.isEnterCurrent) {
    return TextString.currentPin;
  } else if (status.isEnterNew || status.isCurrentEquals) {
    return TextString.updatePin;
  } else {
    return TextString.confirmPin;
  }
}
