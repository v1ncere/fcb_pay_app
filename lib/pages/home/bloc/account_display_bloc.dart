import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_display_event.dart';
part 'account_display_state.dart';

class AccountDisplayBloc extends Bloc<AccountDisplayEvent, AccountDisplayState> {
  AccountDisplayBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _dbRepository = firebaseRealtimeDBRepository,
  super(AccountDisplayInProgress()) {

    // fetching stream data from firebase
    on<AccountDisplayLoaded>((event, emit) {
      _streamSubscription = _dbRepository
      .getAccountsListRealTime()
      .listen((event) async {
        add(AccountDisplayUpdated(event));
      });
    });

    // update accounts display when new data is added
    on<AccountDisplayUpdated>((event, emit) async {
      if (event.accounts.isEmpty) {
        emit(const AccountDisplayError('Empty'));
      } else {
        emit(AccountDisplaySuccess(accounts: event.accounts));
      }
    });
  }
  final FirebaseRealtimeDBRepository _dbRepository;
  late final StreamSubscription<List<Accounts>> _streamSubscription;

  @override
  Future<void> close() {
    _streamSubscription.cancel;
    return super.close();
  }
}