import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app.dart';
import '../otp_link.dart';

class OTPLinkPage extends StatelessWidget {
  const OTPLinkPage({super.key});
  static Page<void> page() => const MaterialPage(child: OTPLinkPage());
  static final _authRepository = FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) => state.args,
      builder: (context, phone) {
        return RepositoryProvider(
          create: (context) => _authRepository,
          child: BlocProvider(
            create: (context) => OtpLinkBloc(authRepository: _authRepository)..add(PhoneNumberSent(phone)),
            child: OTPLinkView(phone: phone),
          )
        );
      }
    );
  }
}