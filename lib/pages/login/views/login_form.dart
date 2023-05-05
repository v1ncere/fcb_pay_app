import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/login/login.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: BlocListener<LoginBloc, LoginState> (
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Authentication Failure')));
            }
          },
          child: Align(
            alignment: const Alignment(0, -1/3),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/fcb-logo.png', height: 120),
                  const SizedBox(height: 16),
                  _EmailInput(),
                  const SizedBox(height: 12),
                  _PasswordInput(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SignInText(),
                      _LoginButton(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _SignUpButton(),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
 
class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginBloc>().add(LoginEmailChanged(email)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0x1FB3B3B3),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF009405),
                width: 2.0,
              )
            ),
            border: const OutlineInputBorder(),
            labelText: 'Email',
            errorText: state.email.displayError?.text(),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0x1FB3B3B3),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF009405),
                width: 2.0
              )
            ),
            border: const OutlineInputBorder(),
            labelText: 'Password',
            errorText: state.password.displayError?.text(),
          ),
        );
      },
    );
  }
}

class _SignInText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Sign In',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: Color(0xFF009405),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
        previous.status != current.status ||
        current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
          ? const CircularProgressIndicator()
          : ClipOval(
            child: Material(
              color:const Color(0xFF009405),
              child: InkWell(
                splashColor: Colors.red,
                onTap: state.isValid
                  ? () => context.read<LoginBloc>().add(LoggedInWithCredentials())
                  : null,
                child: const SizedBox(
                  width: 56,
                  height: 56, 
                  child: Icon(
                    FontAwesomeIcons.rightToBracket,
                    color: Colors.white,
                  )
                ),
              ),
            ),
          );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).pushNamed('/register'),
      child: const Text(
        'CREATE ACCOUNT',
          style: TextStyle(color: Color(0xFF009405),
        ),
      )
    );
  }
}