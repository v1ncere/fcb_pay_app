import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fcb_pay_app/repository/repository.dart';
import 'package:fcb_pay_app/ui/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
        child: BlocProvider(
          create: (context) => SettingsCubit(context.read<AuthenticationRepository>()),
          child: const Center(
            child: SettingsSelection(),
          ),
        ),
    );
  }
}