import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'fund_transfer_accounts_event.dart';
part 'fund_transfer_accounts_state.dart';

class FundTransferAccountBloc extends Bloc<FundTransferAccountEvent, FundTransferAccountState> {
  FundTransferAccountBloc({
    required FirebaseRealtimeDBRepository firebaseRepository
  }) : _realtimeDBRepository = firebaseRepository,
  super(const FundTransferAccountState(status: Status.loading)) {
    on<FundTransferAccountLoaded>(_onFundTransferAccountLoaded);
    on<FundTransferAccountUpdated>(_onFundTransferAccountUpdated);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  StreamSubscription<List<FundTransferAccount>>? _streamSubscription;

  void _onFundTransferAccountLoaded(FundTransferAccountLoaded event, Emitter<FundTransferAccountState> emit) async {
    _streamSubscription?.cancel();
    _streamSubscription = _realtimeDBRepository.getFundTransferListStream()
    .listen((event) {
      add(FundTransferAccountUpdated(event));
    });
  }

  void _onFundTransferAccountUpdated(FundTransferAccountUpdated event, Emitter<FundTransferAccountState> emit) async {
    if (event.account.isNotEmpty) {
      emit(state.copyWith(
        transferAccount: event.account,
        status: Status.success
      ));
    } else {
      emit(state.copyWith(
        status: Status.error,
        error: "Empty"
      ));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
