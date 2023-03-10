import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fcb_pay_app/repository/repository.dart';
import 'package:fcb_pay_app/pages/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthRepository(),
        child: BlocProvider(
          create: (context) => SettingsCubit(context.read<FirebaseAuthRepository>()),
          child: const Center(
            child: SettingsSelection(),
          ),
        ),
    );
  }
}