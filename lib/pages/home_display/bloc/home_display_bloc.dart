import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_display_event.dart';
part 'home_display_state.dart';

class HomeDisplayBloc extends Bloc<HomeDisplayEvent, HomeDisplayState> {
  HomeDisplayBloc({
    required FirebaseRealtimeDBRepository firebaseDatabaseService,
  }): _firebaseDatabaseService = firebaseDatabaseService,
  super(HomeDisplayLoading()) {
    on<HomeDisplayLoaded>(_onHomeDisplayLoaded);
    on<HomeDisplayUpdated>(_onHomeDisplayUpdated);
  }
  final FirebaseRealtimeDBRepository _firebaseDatabaseService;
  StreamSubscription<List<HomeDisplay>>? streamSubscription; // list

  // list
  void _onHomeDisplayLoaded(HomeDisplayLoaded event, Emitter<HomeDisplayState> emit) {
    streamSubscription = _firebaseDatabaseService.getHomeDisplayListRealTime()
    .listen((event) async {
      add(HomeDisplayUpdated(event));
    });
  }

  void _onHomeDisplayUpdated(HomeDisplayUpdated event, Emitter<HomeDisplayState> emit) async {
    if (event.homeDisplay.isEmpty) {
      emit(const HomeDisplayError('EMPTY'));
    } else {
      emit(HomeDisplayLoad(homeDisplay: event.homeDisplay));
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel;
    return super.close();
  }
}