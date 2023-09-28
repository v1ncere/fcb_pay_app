import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ReceiptBloc({
    required HiveRepository hiveRepository,
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _hiveRepository = hiveRepository,
  _firebaseRepository = firebaseRepository,
  super(ReceiptDisplayLoading()) {
    on<ReceiptDisplayLoaded>(_onReceiptDisplayLoaded);
    on<ReceiptDisplayUpdated>(_onReceiptDisplayUpdated);
  }
  final FirebaseRealtimeDBRepository _firebaseRepository;
  final HiveRepository _hiveRepository;
  StreamSubscription<Receipt>? _streamSubscription;
  
  void _onReceiptDisplayLoaded(ReceiptDisplayLoaded event, Emitter<ReceiptState> emit) async {
    final id = await _hiveRepository.getID();
    _streamSubscription?.cancel();
    _streamSubscription = _firebaseRepository.getReceiptStream(id)
    .listen((receipts) async {
      add(ReceiptDisplayUpdated(receipts));
    });
  }

  void _onReceiptDisplayUpdated(ReceiptDisplayUpdated event, Emitter<ReceiptState> emit) async {
    if (event.receipts.title.isNotEmpty) {
      emit(ReceiptDisplaySuccess(receipts: event.receipts));
    } else {
      emit(ReceiptDisplayLoading());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}