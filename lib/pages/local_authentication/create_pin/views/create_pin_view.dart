import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/local_authentication/create_pin/widgets/widgets.dart';
import 'package:fcb_pay_app/pages/local_authentication/local_authentication.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class CreatePinView extends StatelessWidget {
  const CreatePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.setupPin, style: TextStyle(color: Colors.black)),
        leading: BackButton(
          onPressed: () => context.flow<AppStatus>().update((status) => AppStatus.authenticated)
        )
      ),
      body: BlocListener<CreatePinBloc, CreatePinState>(
        listener: (context, state) {
          if (state.status.isEquals) {
            context.read<AuthPinBloc>().add(AuthPinChecked());
            showDialog(
              context: context,
              barrierDismissible: false,
              useRootNavigator: false,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                title: const Center(child: Text(AppString.confirmPinSuccess, textAlign: TextAlign.center)),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () => context.flow<AppStatus>().update((_) => AppStatus.authenticated),
                    child: const Text("OK")
                  )
                ]
              )
            );
          }
          if (state.status.isUnequals) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                title: const Center(child: Text(AppString.confirmPinFailure, textAlign: TextAlign.center)),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK")
                  )
                ]
              )
            );
          }
        },
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 2, child: InputPin()),
            Expanded(flex: 3, child: NumPad())
          ]
        )
      )
    );
  }
}
