import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.widget,
    required this.buttonModel
  });
  final PageWidget widget;
  final ButtonModel buttonModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 2), // line divider ---------------------
        const SizedBox(height: 5),
        const CustomText(text: "Please verify your data for accuracy and completeness before proceeding with the transaction.",
          fontSize: 12,
          color: Colors.teal
        ),
        const SizedBox(height: 15),
        CustomElevatedButton(
          buttonColor: const Color(0xFF25C166),
          title: widget.title,
          titleColor: Colors.white,
          icon: iconMapper(buttonModel.icon),
          iconColor: Colors.white,
          onPressed: () {
            context.read<WidgetsBloc>().add(SubmissionStatusRefresher());
            context.read<WidgetsBloc>().add(ButtonSubmitted(buttonModel.title));
          }
        )
      ]
    );
  }
}