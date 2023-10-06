import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'account_button_event.dart';
part 'account_button_state.dart';

class AccountButtonBloc extends Bloc<AccountButtonEvent, AccountButtonState> {
  AccountButtonBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _firebaseRepository = firebaseRepository,
  super(const AccountButtonState(status: Status.loading)) {
    on<WidgetsFetched>(_onWidgetsFetched);
    on<ButtonsFetched>(_onButtonsFetched);
  }
  final FirebaseRealtimeDBRepository _firebaseRepository;

  void _onWidgetsFetched(WidgetsFetched event, Emitter<AccountButtonState> emit) async {
    try {
      final type = event.type;
      final idList = await _firebaseRepository.getDynamicListStringData('account_widget/$type');
      add(ButtonsFetched(idList));
    } catch (err) {
      emit(state.copyWith(status: Status.error, message: err.toString()));
    }
  }

  void _onButtonsFetched(ButtonsFetched event, Emitter<AccountButtonState> emit) async {
    if (event.ids.isEmpty) {
      emit(state.copyWith(status: Status.error, message: 'Empty'));
      return;
    }
    
    try {
      final results = await Future.wait(event.ids.map((element) => _firebaseRepository.getHomeButton(element)));
      final homeButtons = results.where((value) => value != null).map((value) => value!).toList();

      if (homeButtons.isNotEmpty) {
        emit(state.copyWith(buttonList: homeButtons, status: Status.success));
      } else {
        emit(state.copyWith(status: Status.error, message: 'Empty'));
      }
    } catch (err) {
      emit(state.copyWith(status: Status.error, message: err.toString()));
    }
  }
}
