import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/utils.dart';
import '../../../home_flow/home_flow.dart';
import '../../local_authentication.dart';
import '../widgets/widgets.dart';

class AuthPinView extends StatelessWidget {
  const AuthPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [AppbarTrailingButton()]
      ),
      body: MultiBlocListener(
        listeners: [
          // listen to fingerprint biometric
          BlocListener<BiometricCubit, BiometricState>(
            listener: (context, state) {
              // fingerprint correct
              if (state.status.isAuthenticated) {
                Navigator.of(context).push(HomeFlow.route());
              }
              // fingerprint incorrect
              if (state.status.isUnauthenticated) {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) =>  AlertDialog(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    backgroundColor: ColorString.guardsmanRed,
                    title: Center(
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorString.white)
                      )
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'OK',
                          style: TextStyle(color: ColorString.white)
                        )
                      )
                    ]
                  )
                );
              }
            }
          ),
          // listen to pin code
          BlocListener<AuthPinBloc, AuthPinState>(
            listener: (context, state) {
              // pincode correct
              if (state.status.isEquals) {
                Navigator.of(context).push(HomeFlow.route());
              }
              // pincode incorrect
              if (state.status.isUnequals) {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) =>  AlertDialog(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    backgroundColor: ColorString.guardsmanRed,
                    title: Center(
                      child: Text(
                        TextString.authenticationFailure,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorString.white)
                      )
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'OK', 
                          style: TextStyle(color: ColorString.white)
                        )
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
            const Expanded(
              flex: 2, 
              child: InputPin()
            ),
            BlocSelector<BiometricCubit, BiometricState, bool>(
              selector: (state) => state.biometricsEnabled,
              builder: (context, isEnabled) {
                return Expanded(
                  flex: 4,
                  child: NumPad(isBiometricEnable: isEnabled)
                );
              }
            )
          ]
        )
      )
    );
  }
}