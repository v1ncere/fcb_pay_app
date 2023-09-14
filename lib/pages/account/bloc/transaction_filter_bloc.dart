import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_filter_event.dart';
part 'transaction_filter_state.dart';

class TransactionFilterBloc extends Bloc<TransactionFilterEvent, TransactionFilterState> {
  TransactionFilterBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _dbRepository = firebaseRealtimeDBRepository,
  super(TransactionFilterLoading()) {
    on<TransactionFilterLoaded>(_onTransactionFilterLoaded);
    on<TransactionFilterUpdated>(_onTransactionFilterUpdated);
  }
  final FirebaseRealtimeDBRepository _dbRepository;
  StreamSubscription<TransactionFilter>? _subscription;

  void _onTransactionFilterLoaded(TransactionFilterLoaded event, Emitter<TransactionFilterState> emit) async {
    _subscription?.cancel;
    _subscription = _dbRepository.getTransactionFilterStream()
    .listen((event) {
      add(TransactionFilterUpdated(event));
    });
  }

  void _onTransactionFilterUpdated(TransactionFilterUpdated event, Emitter<TransactionFilterState> emit) async {
    try {
      emit(TransactionFilterSuccess(filter: event.filter));
    } catch (err) {
      emit(TransactionFilterError(err.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel;
    return super.close();
  }
}
