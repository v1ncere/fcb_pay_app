import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class SourceDropdown extends StatelessWidget {
  const SourceDropdown({
    super.key,
    required this.widget
  });
  final PageWidget widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state is AccountsInProgress) {
          return const Center(child: ShimmerRectLoading());
        }
        if (state is AccountsSuccess) {
          return BlocBuilder<WidgetsBloc, WidgetsState>(
            builder: (widgetsContext, widgetsState) {
              return Padding(
                padding: const EdgeInsets.only(top: 5.0 , bottom: 5.0),
                child: CustomDropdownButton(
                  value: null,
                  hint: Text(widget.title),
                  validator: (_) => null,
                  onChanged: (value) {
                    context.read<WidgetsBloc>().add(
                      DynamicWidgetsValueChanged(
                        keyId: widget.keyId!,
                        title: widget.title,
                        value: value!,
                        type: widget.dataType,
                      )
                    );
                  },
                  items: state.accounts.map((item) {
                    return DropdownMenuItem<String> (
                      value: item.keyId.toString(),
                      child: Text('${item.keyId}')
                    );
                  }).toList(),
                ),
              );
            }
          );
        }
        if (state is AccountsError) {
          return Center(
            child: Text(state.error,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w900,
                fontSize: 16.0
              )
            )
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}