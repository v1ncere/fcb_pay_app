import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  TransactionHistoryBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _firebaseRealtimeDBRepository = firebaseRealtimeDBRepository,
  super(TransactionHistoryLoadInProgress()) {
    on<TransactionHistoryLoaded>(_onTransactionHistoryLoaded);
    on<TransactionHistoryUpdated>(_onTransactionHistoryUpdated);
  }
  final FirebaseRealtimeDBRepository _firebaseRealtimeDBRepository;
  StreamSubscription<List<TransactionHistory>>? streamSubscription;

  void _onTransactionHistoryLoaded(TransactionHistoryLoaded event,  Emitter<TransactionHistoryState> emit) async {
    streamSubscription = _firebaseRealtimeDBRepository.getTransactionListRealTime(event.account, event.searchQuery)
    .listen((event) async {
      add(TransactionHistoryUpdated(event));
    });
  }

  void _onTransactionHistoryUpdated(TransactionHistoryUpdated event, Emitter<TransactionHistoryState> emit) async {
    if (event.transactions.isEmpty) {
      emit(const TransactionHistoryLoadError('Empty'));
    } else {
      emit(TransactionHistoryLoadSuccess(transactions: event.transactions));
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel;
    return super.close();
  }
}
