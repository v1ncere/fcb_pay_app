import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _dbRepository = firebaseRealtimeDBRepository,
  super(AccountsInProgress()) {
    on<AccountsLoaded>(_onAccountsLoaded);
    on<AccountsUpdated>(_onAccountsUpdated);
  }
  final FirebaseRealtimeDBRepository _dbRepository;
  StreamSubscription<List<Accounts>>? _streamSubscription;

  // fetching stream data from firebase
  _onAccountsLoaded(AccountsLoaded event, Emitter<AccountsState> emit) async {
    _streamSubscription?.cancel;
    _streamSubscription = _dbRepository.getAccountListStream()
    .listen((event) async {
      add(AccountsUpdated(event));
    });
  }

  // update accounts display when new data is added
  _onAccountsUpdated(AccountsUpdated event, Emitter<AccountsState> emit) async {
    if (event.accounts.isEmpty) {
      emit(const AccountsError('Empty'));
    } else {
      emit(AccountsSuccess(accounts: event.accounts));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel;
    return super.close();
  }
}