import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InactivityCubit extends Cubit<bool> {
  InactivityCubit() : super(true);
  
  Timer? _inactivityTimer;
  bool isTimerPaused = false;

  void resetInactivityState() {
    emit(true);
    resetTimer("RESET\n\n");
  }

  // reset timer if user has an activity on the page
  void resetTimer(String? text) {
    debugPrint(text);
    _inactivityTimer?.cancel();
    if (!isTimerPaused) {
      _inactivityTimer = Timer(const Duration(seconds: 5), () => emit(false));
    }
  }

  // pause timer
  void pauseTimer() {
    _inactivityTimer?.cancel();
    isTimerPaused = true;
  }

  // resume time
  void resumeTimer() {
    isTimerPaused = false;
    resetTimer("RESUME\n\n");
  }

  @override
  Future<void> close() async {
    _inactivityTimer?.cancel();
    return super.close();
  }
}
