import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/local_authentication/local_authentication.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class CreatePinView extends StatelessWidget {
  const CreatePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.setupPinTitle, style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.flow<AppStatus>().update((_) => AppStatus.pin);
          }
        )
      ),
      body: BlocListener<CreatePinBloc, CreatePinState>(
        listener: (context, state) {
          if (state.pinStatus == PinStatus.equals) {
            showDialog(
              context: context,
              barrierDismissible: false,
              useRootNavigator: false,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                title: const Center(child: Text(AppString.pinCreationSuccess, textAlign: TextAlign.center)),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () {
                      context.flow<AppStatus>().update((_) => AppStatus.pin);
                    },
                    child: const Text("OK"),
                  )
                ]
              )
            );
          }
          if (state.pinStatus == PinStatus.unequals) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                title: const Center(child: Text(AppString.pinCreationFailure, textAlign: TextAlign.center)),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
            Expanded(flex: 2, child: CreateInputPinWidget()),
            Expanded(flex: 3, child: CreateNumPad())
          ]
        )
      )
    );
  }
}