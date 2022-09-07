import 'package:fcb_pay_app/db/pin_repository.dart';
import 'package:fcb_pay_app/functions/business_pin_bloc/auth_pin_bloc.dart';
import 'package:fcb_pay_app/pages/home.dart';
import 'package:fcb_pay_app/ui/button_numpad.dart';
import 'package:fcb_pay_app/ui/pin_sphere.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPin extends StatelessWidget {
  static const String setupPIN = "Setup PIN";
  static const String useSixDigitsPIN = "Use 6-digits PIN";
  static const String authenticationSuccess = "Login Success";
  static const String authenticationFailed = "Login Failed";

  //static const String ok = "OK";

  const AuthPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          lazy: false,
          create: (_) => AuthPinBloc(pinRepository: HivePinRepository()),
          child: BlocListener<AuthPinBloc, AuthPinState>(
            listener: (context, state) {
              if (state.pinStatus == AuthPinStatus.equals) {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: Text(authenticationSuccess),
                    actionsAlignment: MainAxisAlignment.center,
                  ),
                );
                Future.delayed(const Duration(seconds: 2), () => Navigator.pushAndRemoveUntil(context, Home.route(), (_) => false));
              } else if (state.pinStatus == AuthPinStatus.unequals) {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: Text(authenticationFailed),
                    actionsAlignment: MainAxisAlignment.center,
                  )
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
    return MaterialPageRoute<void>(builder: (_) => const AuthPin());
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
                  child: ButtonNumPad(num: "1", onPressed: () => BlocProvider.of<AuthPinBloc>(context).add(const AuthPinAddEvent(pinNum: 1)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "2", onPressed: () => BlocProvider.of<AuthPinBloc>(context).add(const AuthPinAddEvent(pinNum: 2)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "3", onPressed: () => BlocProvider.of<AuthPinBloc>(context).add(const AuthPinAddEvent(pinNum: 3)))),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: ButtonNumPad(num: "4", onPressed: () => BlocProvider.of<AuthPinBloc>(context).add(const AuthPinAddEvent(pinNum: 4)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "5", onPressed: () => BlocProvider.of<AuthPinBloc>(context).add(const AuthPinAddEvent(pinNum: 5)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "6", onPressed: () => BlocProvider.of<AuthPinBloc>(context).add(const AuthPinAddEvent(pinNum: 6)))),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: ButtonNumPad(num: "7", onPressed: () => BlocProvider.of<AuthPinBloc>(context).add(const AuthPinAddEvent(pinNum: 7)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "8", onPressed: () => BlocProvider.of<AuthPinBloc>(context).add(const AuthPinAddEvent(pinNum: 8)))),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "9", onPressed: () => BlocProvider.of<AuthPinBloc>(context).add(const AuthPinAddEvent(pinNum: 9)))),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Flexible(
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(num: "0", onPressed: () => BlocProvider.of<AuthPinBloc>(context).add(const AuthPinAddEvent(pinNum: 0)))),
                const SizedBox(width: 40),
                Expanded(
                  child: IconButton(icon: const Icon(Icons.backspace), onPressed: () => BlocProvider.of<AuthPinBloc>(context).add(const AuthPinEraseEvent()))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MainPart extends StatelessWidget {
  static const String enterYourPIN = "Enter your PIN";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthPinBloc, AuthPinState>(
      buildWhen: (previous, current) => previous.pin != current.pin,
      builder: (context, state) {
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Flexible(
            flex: 2,
            child: Text(enterYourPIN, style: TextStyle(color: Color(0xFF687ea1), fontSize: 30)),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) => PinSphere(input: index < state.getCountsOfPIN())),
            ),
          ),
        ]);
      },
    );
  }
}