import 'package:fcb_pay_app/db/pin_repository.dart';
import 'package:fcb_pay_app/functions/business_pin_bloc/create_pin_bloc.dart';
import 'package:fcb_pay_app/pages/home.dart';
import 'package:fcb_pay_app/ui/button_numpad.dart';
import 'package:fcb_pay_app/ui/pin_sphere.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePin extends StatelessWidget {
  static const String setupPin = "Setup PIN";
  static const String useSixDigitsPin = "Use 6-digits PIN";
  static const String pinCreated = "Your PIN code is successfully created";
  static const String pinNonCreated = "PIN codes do not match";
  static const String ok = "OK";

  const CreatePin({Key? key}) : super(key: key);

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
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text(useSixDigitsPin, style: TextStyle(color: Color(0xFF687ea1))),
            )
          )
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          lazy: false,
          create: (_) => CreatePinBloc(pinRepository: HivePinRepository()),
          child: BlocListener<CreatePinBloc, CreatePinState>(
            listener: (context, state) {
              if (state.pinStatus == PinStatus.equals) {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: const Text(pinCreated),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(context, Home.route(), (_) => false),
                        child: const Text(ok),
                      )
                    ],
                  )
                );
              } else if (state.pinStatus == PinStatus.unequals) {
                showDialog(
                  context: context,
                  builder: (context) => Builder(builder: (ctx) =>
                    AlertDialog(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: const Text(pinNonCreated),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                        onPressed: () => BlocProvider.of<CreatePinBloc>(ctx).add(const CreateNullPinEvent()),
                        child: const Text(ok),
                      )
                    ],
                  ))
                );
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: 2, child: _MainPart()),
                Expanded(flex: 3, child: _NumPad()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CreatePin());
  }
}

class _NumPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(64, 0, 64, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: ButtonNumPad(num: "1", onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(pinNum: 1)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "2", onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(pinNum: 2)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "3", onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(pinNum: 3)))),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: ButtonNumPad(num: "4", onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(pinNum: 4)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "5", onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(pinNum: 5)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "6", onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(pinNum: 6)))),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: ButtonNumPad(num: "7", onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(pinNum: 7)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "8", onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(pinNum: 8)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "9", onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(pinNum: 9)))),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Flexible(
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox()),
                const SizedBox(width: 50),
                Expanded(
                  child: ButtonNumPad(num: "0", onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(pinNum: 0)))),
                const SizedBox(width: 50),
                Expanded(
                  child: IconButton(icon: const Icon(Icons.backspace), onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinEraseEvent()))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MainPart extends StatelessWidget {
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
              child: Text(state.pinStatus == PinStatus.enterFirst ? createPIN : reEnterYourPIN, style: const TextStyle(color: Color(0xFF687ea1), fontSize: 30)),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) => PinSphere(input: index < state.getCountOfPin())),
              ),
            ),
          ]
        );
      },
    );
  }
}