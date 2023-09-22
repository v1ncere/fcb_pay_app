import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class DynamicMultiTextfield extends StatelessWidget {
  const DynamicMultiTextfield({
    super.key,
    required this.widget
  });
  final PageWidget widget;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('fund_message_input'),
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLength: 100,
      minLines: 2,
      maxLines: 3,
      onChanged: (value) {
        context.read<WidgetsBloc>().add(DynamicWidgetsValueChanged(
          keyId: widget.keyId!,
          title: widget.title,
          value: value,
          type: widget.dataType,
        ));
      },
      style: const TextStyle(
        color: Colors.black45,
        fontWeight: FontWeight.w700
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(30, 37, 193, 102),
        border: SelectedInputBorderWithShadow(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: 'Enter a message',
        labelStyle: const TextStyle(color: Colors.black26),
        // errorText: state.message.displayError?.text()
      )
    );
  }
}