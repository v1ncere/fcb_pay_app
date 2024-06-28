import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../utils/utils.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ReceiptBloc({
    required HiveRepository hiveRepository,
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _hiveRepository = hiveRepository,
  _firebaseRepository = firebaseRepository,
  super(const ReceiptState(status: Status.loading)) {
    on<ReceiptDisplayLoaded>(_onReceiptDisplayLoaded);
    on<ReceiptDisplayUpdated>(_onReceiptDisplayUpdated);
  }
  final FirebaseRealtimeDBRepository _firebaseRepository;
  final HiveRepository _hiveRepository;
  StreamSubscription<Map<String, dynamic>>? _streamSubscription;

  void _onReceiptDisplayLoaded(ReceiptDisplayLoaded event, Emitter<ReceiptState> emit) async {
    _streamSubscription?.cancel();
    final id = await _hiveRepository.getId();
    _streamSubscription = _firebaseRepository.getDynamicReceiptStream(id)
    .listen((map) async {
      add(ReceiptDisplayUpdated(map));
    });
  }

  void _onReceiptDisplayUpdated(ReceiptDisplayUpdated event, Emitter<ReceiptState> emit) async {
    if (event.receiptMap.isNotEmpty) {
      emit(state.copyWith(status: Status.success, receiptMap: event.receiptMap));
    } else {
      emit(state.copyWith(status: Status.loading));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}