import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/login/login.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status || current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(strokeWidth: 3)
              )
            )
          )
        : ClipOval(
          child: Material(
            color:const Color(0xFF25C166),
            child: InkWell(
              splashColor: Colors.white38,
              onTap: state.isValid
              ? () => context.read<LoginBloc>().add(LoggedInWithCredentials())
              : null,
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
        );
      }
    );
  }
}