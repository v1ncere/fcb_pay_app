import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class DynamicDropdown extends StatelessWidget {
  const DynamicDropdown({
    super.key,
    required this.widget
  });
  final PageWidget widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownBloc, DropdownState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status.isSuccess) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: CustomDropdownButton(
              value: null,
              hint: Text(widget.title),
              onChanged: (value) {
                context.read<WidgetsBloc>().add(DynamicWidgetsValueChanged(
                  keyId: widget.keyId!,
                  title: widget.title,
                  type: widget.dataType,
                  value: value!
                ));
              },
              validator: (value) => null,
              items: state.dropdowns.map((item) {
                return DropdownMenuItem<String> (
                  value: item.toString(),
                  child: Text(item)
                );
              }).toList()
            )
          );
        }
        if (state.status.isError) {
          return Center(
            child: Text(state.error)
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}