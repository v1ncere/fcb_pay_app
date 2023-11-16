import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/local_authentication/local_authentication.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class AuthPinView extends StatelessWidget {
  const AuthPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocSelector<AuthPinBloc, AuthPinState, bool?>(
            selector: (state) => state.pinChecker,
            builder: (context, isExist) {
              return isExist == true
              ? const SizedBox.shrink()
              : Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    child: const Text(AppString.createPin, style: TextStyle(color: Color(0xFF687ea1))),
                    onPressed: () => context.flow<AppStatus>().update((next) => AppStatus.createPin)
                  )
                )
              );
            }
          )
        ]
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<BiometricCubit, BiometricState>(
            listener: (context, state) {
              if (state.status.isAuthenticated) {
                context.flow<AppStatus>().update((_) => AppStatus.authenticated);
              }
              if (state.status.isUnauthenticated) {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) =>  AlertDialog(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: Center(child: Text(state.message, textAlign: TextAlign.center)),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK')
                      )
                    ]
                  )
                );
              }
            }
          ),
          BlocListener<AuthPinBloc, AuthPinState>(
            listener: (context, state) {
              if (state.pinStatus.isEquals) {
                context.flow<AppStatus>().update((state) => AppStatus.authenticated);
              }
              if (state.pinStatus.isUnequals) {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) =>  AlertDialog(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: const Center(child: Text(AppString.authenticationFailure, textAlign: TextAlign.center)),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK')
                      )
                    ]
                  )
                );
              }
            }
          )
        ],
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const UserAccount(),
            const Expanded(flex: 2, child: AuthInputPinWidget()),
            BlocSelector<BiometricCubit, BiometricState, bool>(
              selector: (state) => state.biometricsEnabled,
              builder: (context, isEnabled) {
                return Expanded(flex: 4, child: AuthNumPad(isBiometricEnable: isEnabled));
              }
            )
          ]
        )
      )
    );
  }
}