import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class DynamicTextfield extends StatelessWidget {
  const DynamicTextfield({
    super.key,
    required this.widget
  });
  final PageWidget widget;
  static final _regex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');

  @override
  Widget build(BuildContext context) {
    if (widget.dataType == 'int') {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: CustomTextFormField(
          title: widget.title,
          inputFormatters: <ThousandsFormatter>[ThousandsFormatter(allowFraction: true)],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return value?.isEmpty == true
            ? 'Amount is required'
            : _regex.hasMatch(value!)
              ? null
              : 'Amount is invalid. Please try again.';
          },
          onChanged: (value) {
            context.read<WidgetsBloc>().add(DynamicWidgetsValueChanged(
              keyId: widget.keyId!,
              title: widget.title,
              value: value,
              type: widget.dataType,
            ));
          }
        )
      ); 
    } else if (widget.dataType == 'string') {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: CustomTextFormField(
          title: widget.title,
          validator: (value) {
            return value?.isEmpty == true 
            ? 'Oops! You forgot something. Please fill in this field.'
            : null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            context.read<WidgetsBloc>().add(DynamicWidgetsValueChanged(
              keyId: widget.keyId ?? "",
              title: widget.title,
              value: value,
              type: widget.dataType,
            ));
          }
        )
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}