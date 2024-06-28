import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../sign_up.dart';

enum ButtonName { leading, trailing }

class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.current});
  final int current;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        // otp status
        if (state.otpStatus.isCanceled) {
          context.read<SignUpStepperCubit>().stepContinued();
        }
        if (state.otpStatus.isSuccess) {
          context.read<SignUpBloc>().add(FormSubmitted());
        }
        if (state.otpStatus.isFailure) {
          _showFailureSnackbar(context, state.message);
        }
        // form status
        if (state.formStatus.isSuccess) {
          context.flow<AppStatus>().update((state) => AppStatus.unauthenticated);
          _showSuccessDialog(context, state.message);
        }
        if (state.formStatus.isFailure) {
          _showFailureSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                onPressed: () => _onButtonPressed(context: context, step: current, name: ButtonName.leading, state: state),
                child: Text(_buttonName(current, ButtonName.leading), style: TextStyle(color: ColorString.eucalyptus))
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(ColorString.eucalyptus),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                ),
                onPressed: () => _onButtonPressed(context: context, step: current, name: ButtonName.trailing, state: state),
                child: Text(_buttonName(current, ButtonName.trailing), style: TextStyle(color: ColorString.white))
              )
            ]
          )
        );
      }
    );
  }

  // UTILITY METHODS

  // return string button name
  String _buttonName(int step, ButtonName name) {
    switch(name) {
      case ButtonName.leading:
        return step <= 0 ? 'CANCEL' : 'BACK';
      case ButtonName.trailing:
        return step >= 3 ? 'VERIFY' : 'NEXT';
    }
  }
  
  void _onButtonPressed({
    required BuildContext context,
    required int step, 
    required ButtonName name,
    required SignUpState state
  }) {
    switch(name) {
      case ButtonName.leading:
        if (step <= 0) {
          context.flow<AppStatus>().update((state) => AppStatus.unauthenticated);
        } else {
          context.read<SignUpStepperCubit>().stepCancelled();
        }
        break;
      case ButtonName.trailing:
        switch (step) {
          case 0:
            if (state.email.isValid && state.firstName.isValid && state.lastName.isValid && state.mobile.isValid) {
              context.read<SignUpStepperCubit>().stepContinued();
            } else {
              _showFailureSnackbar(context, TextString.incompleteForm);
            }
            break;
          case 1:
            if (state.password.isValid && state.confirmPassword.isValid) {
              context.read<SignUpStepperCubit>().stepContinued();
            } else {
              _showFailureSnackbar(context, TextString.incompleteForm);
            }
            break;
          case 2:
            if (state.userImage != null) {
              context.read<SignUpBloc>().add(PhoneNumberSent('+63${state.mobile.value.trim()}'));
            } else {
              _showFailureSnackbar(context, TextString.incompleteForm);
            }
            break;
          case 3:
            if(state.pin.isValid) {
              context.read<SignUpBloc>().add(OtpVerified(smsCode: state.pin.value, verificationId: state.verificationId));
            } else {
              _showFailureSnackbar(context, TextString.incompleteForm);
            }
            break;
        }
        break;
    }
  }

  // show success dialog 
  _showSuccessDialog(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.solidCircleCheck,
      backgroundColor: ColorString.eucalyptus,
      foregroundColor: ColorString.mystic
    ));
  }

  // show failure snackbar
  _showFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.triangleExclamation,
      backgroundColor: ColorString.guardsmanRed,
      foregroundColor: ColorString.mystic
    ));
  }
}