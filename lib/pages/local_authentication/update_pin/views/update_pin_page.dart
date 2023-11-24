import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';

import 'package:fcb_pay_app/pages/local_authentication/update_pin/update_pin.dart';

class UpdatePinPage extends StatelessWidget {
  const UpdatePinPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: UpdatePinPage());

  static final HivePinRepository _hivePinRepository = HivePinRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _hivePinRepository,
      child: BlocProvider(
        create: (context) => UpdatePinBloc(hiveRepository: _hivePinRepository),
        child: const UpdatePinView()
      )
    );
  }
}