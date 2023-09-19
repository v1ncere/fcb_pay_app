import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'widgets_event.dart';
part 'widgets_state.dart';

class WidgetsBloc extends Bloc<WidgetsEvent, WidgetsState> {
  WidgetsBloc({
    required FirebaseRealtimeDBRepository firebaseRepository
  }) : _firebaseRepository = firebaseRepository,
  super(const WidgetsState(status: Status.loading)) {
    on<WidgetsLoaded>(_onWidgetsLoaded);
    on<WidgetsUpdated>(_onWidgetsUpdated);
  }
  final FirebaseRealtimeDBRepository _firebaseRepository;
  StreamSubscription<List<HomeButtonWidget>>? _subscription;

  void _onWidgetsLoaded(WidgetsLoaded event, Emitter<WidgetsState> emit) {
    _subscription?.cancel();
    _subscription = _firebaseRepository
    .getWidgetsListStream(event.id)
    .listen((widgetList) async {
      add(WidgetsUpdated(widgetList));
    });
  }

  void _onWidgetsUpdated(WidgetsUpdated event, Emitter<WidgetsState> emit) async {
    if (event.widgetList.isEmpty) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: 'Empty'
      ));
    } else {
      emit(state.copyWith(
        status: Status.success,
        widgetList: event.widgetList
      ));
    }
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    super.close();
  }
}
