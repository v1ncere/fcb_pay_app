import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/register/register.dart';
import 'package:fcb_pay_app/pages/register/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class RegisterMobileNumberView extends StatelessWidget {
  const RegisterMobileNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if(state.status.isSuccess) {
          context.flow<AppStatus>().update((next) => AppStatus.unauthenticated);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            "Registration account successful! We've sent a verification link to your email.",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white
          ));
        }
        if(state.status.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            state.error,
            FontAwesomeIcons.triangleExclamation,
            Colors.red
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MobileNumberInput(phoneNumberFormatter: PhoneNumberFormatter()),
              const SizedBox(height: 12.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  StepperCancelButton(),
                  SizedBox(width: 10),
                  SubmitButton()
                ]
              )          
            ]
          )
        )
      )
    );
  }
}

