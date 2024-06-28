import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app.dart';

class InactivityDetector extends StatelessWidget {
  const InactivityDetector({
    super.key,
    required this.child,
    required this.onInactive
  });
  final Widget child;
  final Function onInactive;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => context.read<InactivityCubit>().resetTimer(),
      onPointerMove: (_) => context.read<InactivityCubit>().resetTimer(),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent) {
            context.read<InactivityCubit>().resetTimer();
          }
        },
        child: BlocListener<InactivityCubit, InactivityState>(
          listener: (context, state) {
            // inactivity will trigger this event
            if (state.status.isInactive) {
              onInactive();
            }
          },
          child: child
        )
      )
    );
  }
}
