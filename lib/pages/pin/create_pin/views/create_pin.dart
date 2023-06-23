import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/pin/create_pin/create_pin.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';

class CreatePin extends StatelessWidget {
  const CreatePin({super.key});

  static const String setupPin = "Setup PIN";
  static const String useSixDigitsPin = "Use 6-digits PIN";
  static const String pinCreated = "Your PIN code is successfully created";
  static const String pinNonCreated = "PIN codes do not match";
  static const String ok = "OK";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(setupPin, style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: BlocProvider(
          lazy: false,
          create: (_) => CreatePinBloc(baseHivePinService: HivePinRepository()),
          child: BlocListener<CreatePinBloc, CreatePinState>(
            listener: (context, state) {
              if (state.pinStatus == PinStatus.equals) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: const Center(child: Text(pinCreated, textAlign: TextAlign.center,)),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false),
                        child: const Text(ok),
                      )
                    ],
                  )
                );
              } else if (state.pinStatus == PinStatus.unequals) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                    AlertDialog(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: const Center(child: Text(pinNonCreated)),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<CreatePinBloc>(context).add(CreateNullPinEvent());
                          Navigator.of(context).pop();
                        },
                        child: const Text(ok),
                      )
                    ],
                  )
                );
              }
            },
            child: const Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: 2, child: CreateInputPinWidget()),
                Expanded(flex: 3, child: CreateNumPad()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}