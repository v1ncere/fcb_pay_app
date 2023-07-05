import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fund_transfer_accounts_event.dart';
part 'fund_transfer_accounts_state.dart';

class FundTransferAccountBloc extends Bloc<FundTransferAccountEvent, FundTransferAccountState> {
  FundTransferAccountBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository
  }) : _realtimeDBRepository = firebaseRealtimeDBRepository,
  super(const FundTransferAccountState()) {
    on<FundTransferAccountLoaded>(_onFundTransferAccountLoaded);
    on<FundTransferAccountUpdated>(_onFundTransferAccountUpdated);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  StreamSubscription<List<FundTransferAccount>>? _subscription;

  void _onFundTransferAccountLoaded(FundTransferAccountLoaded event, Emitter<FundTransferAccountState> emit) async {
    emit(state.copyWith(status: FundTransferAccountStatus.loading));

    _subscription = _realtimeDBRepository.getFundTransferList()
    .listen((event) {
      add(FundTransferAccountUpdated(event));
    });
  }

  void _onFundTransferAccountUpdated(FundTransferAccountUpdated event, Emitter<FundTransferAccountState> emit) async {
    if (event.account.isNotEmpty) {
      emit(state.copyWith(
        transferAccount: event.account,
        status: FundTransferAccountStatus.success
      ));
    } else {
      emit(state.copyWith(
        status: FundTransferAccountStatus.error,
        error: "Empty"
      ));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
