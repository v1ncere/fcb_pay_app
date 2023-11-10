import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';

class InactivityDetector extends StatelessWidget {
  const InactivityDetector({
    super.key,
    required this.child,
    required this.onInactive,
  });
  final Widget child;
  final Function onInactive;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => context.read<InactivityCubit>().resetTimer("TAPPED\n\n"),
      onPointerMove: (_) => context.read<InactivityCubit>().resetTimer("POINTER MOVED\n\n"),
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            context.read<InactivityCubit>().resetTimer("KEY PRESSED\n\n");
          }
        },
        child: BlocListener<InactivityCubit, bool>(
          listener: (context, isActive) {
            if (!isActive) {
              onInactive();
            }
          },
          child: child
        )
      )
    );
  }
}