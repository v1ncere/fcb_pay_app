import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../dynamic_viewer.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.widget,
    required this.button
  });
  final PageWidget widget;
  final Button button;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 2), // line divider
        const SizedBox(height: 5),
        _note(
          text: TextString.transactionNote,
          fontSize: 12,
          color: Colors.teal
        ),
        const SizedBox(height: 15),
        CustomElevatedButton(
          buttonColor: const Color(0xFF25C166),
          title: widget.title,
          titleColor: Colors.white,
          icon: iconMapper(button.icon),
          iconColor: Colors.white,
          onPressed: () => showDialog(
            context: context,
            builder: (ctx) => BlocProvider.value(
              value: BlocProvider.of<WidgetsBloc>(context),
              child: CustomAlertDialog(
                description: 'Are you sure you want to proceed?', 
                title: button.title, 
                onPressed: () {
                  context.read<WidgetsBloc>().add(ButtonSubmitted(button.title));
                  Navigator.of(ctx).pop();
                }
              )
            )
          )
        )
      ]
    );
  }

  Text _note({
    required String text,
    required double? fontSize,
    required Color color,
    FontWeight? fontWeight,
  }) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontSize: fontSize,
        shadows: <Shadow>[
          Shadow(
            color: Colors.black.withOpacity(0.15), // Shadow color
            blurRadius: 1,
            offset: const Offset(0, 1)
          )
        ]
      )
    );
  }
}