import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buttons_event.dart';
part 'buttons_state.dart';

class ButtonsBloc extends Bloc<ButtonsEvent, ButtonsState> {
  ButtonsBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _realtimeDBRepository = firebaseRealtimeDBRepository,
  super(ButtonsLoading()) {
    on<ButtonsLoaded>(_onButtonsLoaded);
    on<ButtonsUpdated>(_onButtonsUpdated);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  StreamSubscription<List<HomeButton>>? _streamSubscription;

  void _onButtonsLoaded(ButtonsLoaded event, Emitter<ButtonsState> emit) {
    _streamSubscription?.cancel();
    _streamSubscription = _realtimeDBRepository
    .getHomeButtonsListStream()
    .listen((event) async {
      add(ButtonsUpdated(event));
    });
  }

  void _onButtonsUpdated(ButtonsUpdated event, Emitter<ButtonsState> emit) {
    if (event.homeButton.isNotEmpty) {
      emit(ButtonsSuccess(event.homeButton));
    } else {
      emit(const ButtonsError(error: 'Empty')); 
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel;
    return super.close();
  }
}
