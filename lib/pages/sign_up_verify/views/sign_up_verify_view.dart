import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../../app/app.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../sign_up_verify.dart';
import '../widgets/widgets.dart';

class SignUpVerifyView extends StatelessWidget {
  const SignUpVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpVerifyBloc, SignUpVerifyState>(
      listener: (context, state) {
        if (state.formStatus.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: state.message,
            icon: FontAwesomeIcons.triangleExclamation,
            backgroundColor: ColorString.guardsmanRed,
            foregroundColor: ColorString.mystic
          ));
        }
        if (state.formStatus.isSuccess) {
          context.flow<AppStatus>().update((state) => AppStatus.signup);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: 'Account Available',
            icon: FontAwesomeIcons.solidCircleCheck,
            backgroundColor: ColorString.eucalyptus, 
            foregroundColor: ColorString.mystic
          ));
        }
      },
      builder: (context, state) {
        const shrink = SizedBox.shrink();
        return LoadingStack(
          isLoading: state.formStatus.isInProgress,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(FontAwesomeIcons.x, size: 18)
                )
              ]
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  const TitleText(),
                  const SizedBox(height:  20),
                  const AccountTypeDropdown(),
                  state.accountType.isUnknown ? shrink : const SizedBox(height:  20),
                  state.accountType.isUnknown ? shrink : const AccountNumber(),
                  state.accountType.isSavings ? const SizedBox(height: 20) : shrink,
                  state.accountType.isSavings ? const FullName() : shrink,
                  state.accountType.isUnknown ? shrink : const SizedBox(height: 20),
                  state.accountType.isUnknown ? shrink : const DateOfBirth()
                ]
              )
            ),
            bottomNavigationBar: const Padding(
              padding: EdgeInsets.all(15.0),
              child: SubmitButton()
            )
          )
        );
      }
    );
  }
}
