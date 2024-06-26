import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'router_event.dart';
part 'router_state.dart';

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc() : super(const RouterState()) {
    // account saved in state from [home page]
    on<RouterAccountsPassed>((event, emit) {
      emit(state.copyWith(status: HomeRouterStatus.account, account: event.account));
    });
    // a data saved in state from [notification page]
    on<RouterNotificationArgsPassed>((event, emit) {
      emit(state.copyWith(status: HomeRouterStatus.notificationViewer, args: event.args));
    });
    // button saved in state from [payments page]
    on<RouterPaymentsButtonPassed>((event, emit) {
      emit(state.copyWith(status: HomeRouterStatus.paymentsView, button: event.button));
    });
    // button saved in state from [transfers page]
    on<RouterTransfersButtonPassed>((event, emit) {
      emit(state.copyWith(status: HomeRouterStatus.transfersView, button: event.button));
    });
    // button saved in state from [account page]
    on<RouterAccountsButtonPassed>((event, emit) {
      emit(state.copyWith(status: HomeRouterStatus.accountsViewer, button: event.button));
    });
  }
}
