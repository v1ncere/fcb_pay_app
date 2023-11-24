import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';

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
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            context.read<InactivityCubit>().resetTimer();
          }
        },
        child: BlocListener<InactivityCubit, InactivityState>(
          listenWhen: (previous, current) => true,
          listener: (context, state) {
            if (state.status.isInactive) {
              debugPrint('INACTIVITY ACTION TRIGGERED');
              onInactive();
            }
          },
          child: child
        )
      )
    );
  }
}