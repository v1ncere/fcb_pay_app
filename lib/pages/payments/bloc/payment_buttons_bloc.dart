import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

part 'payment_buttons_event.dart';
part 'payment_buttons_state.dart';

class PaymentButtonsBloc extends Bloc<PaymentButtonsEvent, PaymentButtonsState> {
  PaymentButtonsBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository
  }) : _realtimeDBRepository = firebaseRealtimeDBRepository,
  super(PaymentButtonsLoading()) {
    on<PaymentButtonsLoaded>(_onPaymentButtonsLoaded);
    on<PaymentButtonsUpdated>(_onPaymentButtonsUpdated);
    on<PaymentButtonsRefreshed>(_onPaymentButtonsRefreshed);
    on<PaymentButtonsFailed>(_onPaymentButtonsFailed);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  StreamSubscription<List<Button>>? _streamSubscription;

  FutureOr<void> _onPaymentButtonsLoaded(PaymentButtonsLoaded event, Emitter<PaymentButtonsState> emit) async {
    final internetStatus = await checkNetworkStatus();

    if (internetStatus) {
      _streamSubscription?.cancel();
      _streamSubscription = _realtimeDBRepository.getButtonListStream()
      .listen((event) async {
        add(PaymentButtonsUpdated(event));
      }, onError: (error) {
        add(PaymentButtonsFailed(error.toString()));
      });
    } else {
      emit(const PaymentButtonsError(message: 'disconnected...'));
    }
  }

  FutureOr<void> _onPaymentButtonsUpdated(PaymentButtonsUpdated event, Emitter<PaymentButtonsState> emit) async {
    if (event.buttonList.isNotEmpty) {
      // list of buttons
      final buttons = event.buttonList;
      // filter only the payment type buttons
      final paymentButtons = buttons.where((button) => button.type == 'payment').toList();
      paymentButtons.sort((a, b) => a.position!.compareTo(b.position!));
      emit(PaymentButtonsSuccess(paymentButtons));
    } else {
      emit(const PaymentButtonsError(message: 'Empty'));
    }
  }

  void _onPaymentButtonsRefreshed(PaymentButtonsRefreshed event, Emitter<PaymentButtonsState> emit) {
    emit(PaymentButtonsLoading());
    add(PaymentButtonsLoaded());
  }

  void _onPaymentButtonsFailed(PaymentButtonsFailed event, Emitter<PaymentButtonsState> emit) {
    emit(PaymentButtonsError(message: event.message));
  }

  @override
  Future<void> close() async {
    _streamSubscription?.cancel();
    return super.close();
  }
}
