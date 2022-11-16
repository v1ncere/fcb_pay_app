import 'package:fcb_pay_app/repository/authentication_repository/authentication_repository.dart';
import 'package:fcb_pay_app/ui/settings/cubit/settings_cubit.dart';
import 'package:fcb_pay_app/ui/settings/widgets/settings_selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

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