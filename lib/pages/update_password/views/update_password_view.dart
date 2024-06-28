import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../../app/app.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../home_flow/home_flow.dart';
import '../update_password.dart';
import '../widgets/widgets.dart';

class UpdatePasswordView extends StatelessWidget {
  const UpdatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return InactivityDetector(
      onInactive: () => context.flow<HomeRouterStatus>().complete(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Update Password',
            style: TextStyle(
              color: ColorString.jewel,
              fontWeight: FontWeight.w700
            )
          ),
          actions: [
            IconButton(
              onPressed: () => context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.appBar),
              icon: const Icon(FontAwesomeIcons.x, size: 18)
            )
          ]
        ),
        body: BlocListener<UpdatePasswordBloc, UpdatePasswordState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              final msg = state.message ?? '';
              if (msg == 'requires-recent-login') {
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  customSnackBar(
                    text: 'Password update requires recent login. Please sign in again to proceed.',
                    icon: FontAwesomeIcons.triangleExclamation,
                    backgroundColor: ColorString.guardsmanRed,
                    foregroundColor: ColorString.mystic
                  )
                );
                context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.reauthenticate);
              } else {
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  customSnackBar(
                    text: msg,
                    icon: FontAwesomeIcons.triangleExclamation,
                    backgroundColor: ColorString.guardsmanRed,
                    foregroundColor: ColorString.mystic
                  )
                );
              }
            }
            if (state.status.isSuccess) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar(
                text: 'Password Update Successful!',
                icon: FontAwesomeIcons.circleCheck,
                backgroundColor: ColorString.eucalyptus,
                foregroundColor: ColorString.mystic
              ));
              context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.settings);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              color: ColorString.jewel,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              ),
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),        
                    NewPasswordTextField(),
                    SizedBox(height: 10),  
                    ConfirmNewPasswordTextField(),
                    SizedBox(height: 20),                              
                    UpdatePasswordButton(),
                    SizedBox(height: 10)
                  ]
                )
              )
            )
          )
        )
      ),
    );
  }
}
