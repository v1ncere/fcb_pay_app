import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';

import 'package:fcb_pay_app/pages/pin/pin.dart';

class CreatePinPage extends StatelessWidget {
  const CreatePinPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: CreatePinPage());

  static final HivePinRepository _hivePinRepository = HivePinRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _hivePinRepository,
      child: BlocProvider(
        lazy: true,
        create: (context) => CreatePinBloc(hivePinRepository: _hivePinRepository),
        child: const CreatePinView()
      )
    );
  }
}