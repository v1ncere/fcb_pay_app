import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dynamic_viewer.dart';
import 'widgets.dart';

class DropdownDisplay extends StatelessWidget {
  const DropdownDisplay({
    super.key,
    required this.pageWidget,
    required this.focusNode
  });
  final PageWidget pageWidget;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    if(_isUserAccount(pageWidget)) {
      return SourceDropdown(focusNode: focusNode, widget: pageWidget);
    } else {
      _fetchDropdown(context, pageWidget);
      return Column(
        children: [
          DynamicDropdown(focusNode: focusNode, widget: pageWidget),
          if (pageWidget.additional == true)
            const ExtraWidgets()
        ]
      );
    }
  }

  // utility methods
  // search for the node that
  bool _isUserAccount(PageWidget widget) => widget.node.contains('user_account');

  void _fetchDropdown(BuildContext context, PageWidget widget) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    // reference base on the 'dynamic_viewer_widget' child 'node'
    final reference = widget.node.replaceAll('{id}', uid);
    context.read<DropdownBloc>().add(DropdownFetched(reference));
  }
}