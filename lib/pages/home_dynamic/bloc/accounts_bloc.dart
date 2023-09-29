import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _dbRepository = firebaseRepository,
  super(AccountsInProgress()) {
    on<AccountsLoaded>(_onAccountsLoaded);
    on<AccountsUpdated>(_onAccountsUpdated);
  }
  final FirebaseRealtimeDBRepository _dbRepository;
  StreamSubscription<List<Account>>? _streamSubscription;

  // fetching streamed data from firebase
  _onAccountsLoaded(AccountsLoaded event, Emitter<AccountsState> emit) {
    _streamSubscription?.cancel;
    _streamSubscription = _dbRepository.getAccountListStream()
    .listen((data) async {
        add(AccountsUpdated(data));
      }, onError: (error) {
        emit(AccountsError(error.toString()));
      }
    );
  }

  // update accounts display when new data is added
  _onAccountsUpdated(AccountsUpdated event, Emitter<AccountsState> emit) async {
    if (event.accounts.isEmpty) {
      emit(const AccountsError('Empty'));
    } else {
      List<Account> accountList = event.accounts;
      final walletAccount = accountList.firstWhere((acc) => acc.type.trim().toLowerCase() == 'wallet');
      final otherAccount = accountList.where((acc) => acc.type.trim().toLowerCase() != 'wallet').toList();
      
      final sortedAccounts = [ walletAccount, ...otherAccount ];
      emit(AccountsSuccess(accounts: sortedAccounts));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel;
    return super.close();
  }
}
