import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

part 'transfer_buttons_event.dart';
part 'transfer_buttons_state.dart';

class TransferButtonsBloc extends Bloc<TransferButtonsEvent, TransferButtonsState> {
  TransferButtonsBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _realtimeDBRepository = firebaseRealtimeDBRepository,
  super(const TransferButtonsState(status: Status.loading)) {
    on<TransferButtonsLoaded>(_onTransferButtonsLoaded);
    on<TransferButtonsUpdated>(_onTransferButtonsUpdated);
    on<TransferButtonsRefreshed>(_onTransferButtonsRefreshed);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  StreamSubscription<List<Button>>? _streamSubscription;

  FutureOr<void> _onTransferButtonsLoaded(TransferButtonsLoaded event, Emitter<TransferButtonsState> emit)  async {
    final internetStatus = await checkNetworkStatus();
    if (internetStatus) {
      _streamSubscription?.cancel();
      _streamSubscription = _realtimeDBRepository
      .getButtonListStream()
      .listen((event) async {
        add(TransferButtonsUpdated(event));
      }, onError: (error, stackTrace) {
        emit(state.copyWith(status: Status.error, message: error.toString()));
      });
    } else {
      emit(state.copyWith(status: Status.error, message: 'disconnected...'));
    }
  }

  FutureOr<void> _onTransferButtonsUpdated(TransferButtonsUpdated event, Emitter<TransferButtonsState> emit) async {
    if (event.buttonList.isNotEmpty) {
      final buttons = event.buttonList;
      final transferButtons = buttons.where((button) => button.type == 'transfer').toList();
      transferButtons.sort((a, b) => a.position!.compareTo(b.position!));
      emit(state.copyWith(status: Status.success, buttons: transferButtons));
    } else {
      emit(state.copyWith(status: Status.error, message: 'Empty'));
    }
  }

  FutureOr<void> _onTransferButtonsRefreshed(TransferButtonsRefreshed event, Emitter<TransferButtonsState> emit) {
    emit(state.copyWith(status: Status.loading));
    add(TransferButtonsLoaded()); 
  }

  @override
  Future<void> close() async {
    _streamSubscription?.cancel();
    return super.close();
  }
}
