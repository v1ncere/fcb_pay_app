import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app.dart';
import '../../../../utils/utils.dart';
import '../authentication_pin.dart';

class AppbarTrailingButton extends StatelessWidget {
  const AppbarTrailingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCheckerBloc, AuthCheckerState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state.status.isSuccess) {
          return state.isPinExist
          ? TextButton(
              onPressed: () => context.flow<AppStatus>().update((next) => AppStatus.updatePin),
              child: Text(
                TextString.updatePin,
                style: TextStyle(
                  color: ColorString.blazeOrange,
                  fontWeight: FontWeight.bold
                )
              )
            )
          : TextButton(
              onPressed: () => context.flow<AppStatus>().update((next) => AppStatus.createPin),
              child: Text(
                TextString.createPin,
                style: TextStyle(
                  color: ColorString.jewel,
                  fontWeight: FontWeight.bold
                )
              )
            );
        }
        if (state.status.isFailure) {
          return const Center(child: Text('Error Occured'));
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}