import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/repository/repository.dart';

part 'home_display_event.dart';
part 'home_display_state.dart';

class HomeDisplayBloc extends Bloc<HomeDisplayEvent, HomeDisplayState> {
  HomeDisplayBloc({
    required FirebaseDatabaseService firebaseDatabaseService,
  }): _firebaseDatabaseService = firebaseDatabaseService,
  super(HomeDisplayLoading()) {
    on<HomeDisplayLoaded>(_onHomeDisplayLoaded);
    on<HomeDisplayUpdated>(_onHomeDisplayUpdated);
  }
  final FirebaseDatabaseService _firebaseDatabaseService;
  StreamSubscription<HomeDisplay>? streamSubscription;

  void _onHomeDisplayLoaded(HomeDisplayLoaded event, Emitter<HomeDisplayState> emit) {
    streamSubscription?.cancel;
    streamSubscription = _firebaseDatabaseService.getHomeDisplayRealTime()
    .listen((event) async {
      add(HomeDisplayUpdated(event));
    });
      
  }

  void _onHomeDisplayUpdated(HomeDisplayUpdated event, Emitter<HomeDisplayState> emit) async {
    emit(HomeDisplayLoad(homeDisplay: event.homeDisplay));
  }
}