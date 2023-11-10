import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/pages/dynamic_viewer/widgets/widgets.dart';

class DropdownSwitcher extends StatelessWidget {
  const DropdownSwitcher({
    super.key,
    required this.widget,
    required this.focusNode
  });
  final PageWidget widget;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final ref = widget.node.replaceAll('{id}', FirebaseAuth.instance.currentUser!.uid);
    if(widget.node.contains('user_account')) {
      return SourceDropdown(focusNode: focusNode, widget: widget);
    } else {
      context.read<DropdownBloc>().add(DropdownFetched(ref));
      return Column(
        children: [
          DynamicDropdown(focusNode: focusNode, widget: widget), // dropdown button
          widget.additional == true 
          ? const ExtraWidgets() // additional widgets
          : const SizedBox.shrink()
        ]
      );
    }
  }
}