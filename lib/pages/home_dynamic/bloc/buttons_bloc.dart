import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buttons_event.dart';
part 'buttons_state.dart';

class ButtonsBloc extends Bloc<ButtonsEvent, ButtonsState> {
  ButtonsBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _realtimeDBRepository = firebaseRepository,
  super(ButtonsLoading()) {
    on<ButtonsLoaded>(_onButtonsLoaded);
    on<ButtonsUpdated>(_onButtonsUpdated);
    on<ButtonsRefreshed>(_onButtonsRefreshed);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  StreamSubscription<List<HomeButton>>? _streamSubscription;

  void _onButtonsLoaded(ButtonsLoaded event, Emitter<ButtonsState> emit) async {
    final internetStatus = await internetChecker();

    if (internetStatus) {
      _streamSubscription?.cancel();
      _streamSubscription = _realtimeDBRepository.getHomeButtonsListStream()
      .listen(
        (event) async {
          add(ButtonsUpdated(event));
        }, onError: (error) {
          emit(ButtonsError(message: error.toString()));
        }
      );
    } else {
      emit(const ButtonsError(message: 'disconnected...'));
    }
  }

  void _onButtonsUpdated(ButtonsUpdated event, Emitter<ButtonsState> emit) async {
    if (event.homeButton.isNotEmpty) {
      final buttonList = event.homeButton;
      buttonList.sort((a, b) => a.position.compareTo(b.position));

      emit(ButtonsSuccess(buttonList));
    } else {
      emit(const ButtonsError(message: 'Empty'));
    }
  }

  void _onButtonsRefreshed(ButtonsRefreshed event, Emitter<ButtonsState> emit) {
    emit(ButtonsLoading());
    add(ButtonsLoaded());
  }

  @override
  Future<void> close() async {
    _streamSubscription?.cancel;
    return super.close();
  }
}
