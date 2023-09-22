import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      buttonColor: const Color(0xFF25C166),
      title: 'Transfer',
      titleColor: Colors.white,
      // icon: FontAwesomeIcons.moneyBillTransfer,
      iconColor: Colors.white,
      onPressed: () => context.read<WidgetsBloc>().add(ButtonSubmitted()),
    );
  }
}