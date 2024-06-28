import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app.dart';
import '../multi_factor_auth.dart';

class MultiFactorAuthPage extends StatelessWidget {
  const MultiFactorAuthPage({super.key});
  static Page<void> page() => const MaterialPage(child: MultiFactorAuthPage());
  static final _firebaseAuth = FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) => state.args,
      builder: (context, phone) {
        return RepositoryProvider(
          create: (context) => _firebaseAuth,
          child: BlocProvider(
            create: (context) => MfaBloc(firebaseAuth: _firebaseAuth)..add(MFAPhoneNumberSent(phone)),
            child: const MultiFactorAuthView()
          )
        );
      }
    );
  }
}
