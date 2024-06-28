import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../local_authentication.dart';

class InputPin extends StatelessWidget {
  const InputPin({super.key});

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
              child: Text(
                TextString.enterYourPIN,
                style: TextStyle(
                  color: Color(0xFF687ea1),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )
              )
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) => PinSphere(input: index < state.getCountsOfPIN())),
              )
            )
          ]
        );
      }
    );
  }
}