import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../update_password.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: UpdatePasswordPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePasswordBloc(),
      child: const UpdatePasswordView()
    );
  }
}