import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../../app/app.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../login.dart';
import '../widgets/widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState> (
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if(state.status.isSuccess) {
          context.flow<AppStatus>().update((state) => AppStatus.authenticated);
        }
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: state.message,
            icon: FontAwesomeIcons.triangleExclamation,
            backgroundColor: ColorString.guardsmanRed,
            foregroundColor: ColorString.mystic,
          ));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: LoadingStack(
            isLoading: state.status.isInProgress,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Align(
                  alignment: const Alignment(0, -1/3),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(AssetString.profileData, height: 120),
                        const SizedBox(height: 16),
                        state.loginOption.isEmail
                        ? const EmailInput()
                        : const MobileNumberInput(),
                        const SizedBox(height: 12),
                        state.loginOption.isEmail
                        ? const PasswordInput()
                        : const OtpInput(),
                        const SizedBox(height: 16),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SignInText(),
                            LoginButton()
                          ]
                        ),
                        const LoginOptions(),
                        Divider(
                          endIndent: MediaQuery.of(context).size.width * 0.35,
                          indent: MediaQuery.of(context).size.width * 0.35,
                          color: ColorString.algaeGreen,
                        ),
                        const SignUpButton(),
                      ]
                    )
                  )
                )
              )
            ),
          )
        );
      }
    );
  }
}