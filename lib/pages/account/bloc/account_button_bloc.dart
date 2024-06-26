import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

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
      final type = event.type; // acount type e.g.(wallet, cc, sa)
      final idList = await _firebaseRepository.getDynamicListStringData('account_action_button/$type'); // firebase 'account_widget' reference
      
      add(ButtonsFetched(idList));
    } catch (e) {
      emit(state.copyWith(status: Status.error, message: e.toString()));
    }
  }

  // this will be called from _onWidgetsFetched()
  void _onButtonsFetched(ButtonsFetched event, Emitter<AccountButtonState> emit) async {
    if (event.ids.isEmpty) {
      emit(state.copyWith(status: Status.error, message: TextString.empty));
      return;
    }
    
    try {
      // map list of id's and return list of button base on single id
      final results = await Future.wait(event.ids.map((element) => _firebaseRepository.getButton(element)));
      // check if result is not empty
      final homeButtons = results.where((value) => value != null).map((value) => value!).toList();
      
      if (homeButtons.isNotEmpty) {
        emit(state.copyWith(status: Status.success, buttonList: homeButtons));
      } else {
        emit(state.copyWith(status: Status.error, message: TextString.empty));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, message: e.toString()));
    }
  }
}