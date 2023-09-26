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
  });
  final PageWidget widget;

  @override
  Widget build(BuildContext context) {
    final ref = widget.node.replaceAll('{id}', FirebaseAuth.instance.currentUser!.uid);
    if(widget.node.contains('user_account')) {
      return SourceDropdown(widget: widget);
    } else {
      context.read<DropdownBloc>().add(DropdownFetched(ref));
      return Column(
        children: [
          DynamicDropdown(widget: widget),
          const ExtraWidgets() // additional widgets
        ]
      );
    }
  }
}