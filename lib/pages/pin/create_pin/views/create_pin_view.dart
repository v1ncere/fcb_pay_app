import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/pin/create_pin/create_pin.dart';

class CreatePinView extends StatelessWidget {
  const CreatePinView({super.key});

  static const String setupPinTitle = "Setup PIN";
  static const String useSixDigitsPin = "Use a 6-digit PIN";
  static const String pinCreationSuccess = "Your PIN code has been successfully created";
  static const String pinCreationFailure = "The entered PIN codes do not match";
  static const String ok = "OK";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(setupPinTitle, style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
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
                title: const Center(child: Text(pinCreationSuccess, textAlign: TextAlign.center,)),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if(Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(ok),
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
                title: const Center(child: Text(pinCreationFailure, textAlign: TextAlign.center)),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(ok)
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
            Expanded(flex: 3, child: CreateNumPad()),
          ]
        )
      )
    );
  }
}