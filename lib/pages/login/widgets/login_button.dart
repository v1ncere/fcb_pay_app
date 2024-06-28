import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../login.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status || current.isValid,
      builder: (context, state) {
        return Container(
          decoration:  BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0.3,
                blurRadius: 2,
                offset: const Offset(0, 1)
              )
            ]
          ),
          child: ClipOval(
            clipBehavior: Clip.antiAlias,
            child: Material(
              color:const Color(0xFF25C166),
              child: InkWell(
                splashColor: Colors.white38,
                onTap: state.loginOption.isEmail
                ? () => _emialAndPasswordAuth(context)
                : () => _phoneAuth(context, state),
                child: const SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    FontAwesomeIcons.rightToBracket,
                    color: Colors.white
                  )
                )
              )
            )
          )
        );
      }
    );
  }
}

void _emialAndPasswordAuth(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus(); // 
  context.read<LoginBloc>().add(LoggedInWithCredentials());
}

void _phoneAuth(BuildContext context, LoginState state) {
  FocusManager.instance.primaryFocus?.unfocus(); //
  context.read<LoginBloc>().add(OtpVerified(smsCode: state.otp.value, verificationId: state.verificationId));
}