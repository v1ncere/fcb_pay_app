import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_flow/home_flow.dart';
import '../otp_verification.dart';

class OTPVerificationPage extends StatelessWidget {
  const OTPVerificationPage({super.key});
  static Page<void> page() => const MaterialPage(child: OTPVerificationPage());
  static final _authRepository = FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RouterBloc, RouterState, String>(
      selector: (state) => state.args,
      builder: (context, phone) {
        return BlocProvider(
          create: (context) => OtpVerificationBloc(authRepository: _authRepository)..add(PhonNumberSent(phone)),
          child: OTPVerificationView(phone: phone),
        );
      }
    );
  }
}