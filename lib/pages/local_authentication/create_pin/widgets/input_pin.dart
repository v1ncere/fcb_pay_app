import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../local_authentication.dart';

class InputPin extends StatelessWidget {
  const InputPin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePinBloc, CreatePinState>(
      buildWhen: (previous, current) =>
        previous.newPin != current.newPin ||
        previous.confirmedPin != current.confirmedPin,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                state.status == PinStatus.enterNew 
                ? TextString.createPin 
                : TextString.confirmPin,
                style: const TextStyle(
                  color: Color(0xFF687ea1),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
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
