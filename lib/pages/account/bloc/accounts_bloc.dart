import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _firebaseDatabase = firebaseRepository,
   super(const AccountsState(status: Status.loading)) {
    on<AccountsLoaded>(_onAccountsLoaded);
    on<AccountsUpdated>(_onAccountsUpdated);
    on<AccountsRefreshed>(_onAccountsRefreshed);
  }
  final FirebaseRealtimeDBRepository _firebaseDatabase;
  StreamSubscription<List<Account>>? _streamSubscription;

  FutureOr<void> _onAccountsLoaded(AccountsLoaded event, Emitter<AccountsState> emit) async {
    final isConnected = await checkNetworkStatus();
    
    if (isConnected) {
      _streamSubscription?.cancel();
      _streamSubscription = _firebaseDatabase.getAccountListStream()
      .listen((accountList) {
        add(AccountsUpdated(accountList, event.account));
      }, onError: (error) {
        emit(state.copyWith(status: Status.error, message: error.toString()));
      });
    } else {
      emit(state.copyWith(status: Status.error, message: TextString.internetError));
    }
  }

  FutureOr<void> _onAccountsUpdated(AccountsUpdated event, Emitter<AccountsState> emit) {
    if (event.accountList.isNotEmpty) {
      // assign to a new List
      final accountList = event.accountList;
      // get all Accounts with the same category
      final sameCategoryList = accountList.where((account) => account.category == event.account.category).toList();
      // find the Account specified by user to display first
      final first = sameCategoryList.firstWhere((account) => account.accountKeyID! == event.account.accountKeyID!);
      // other Accounts remaining
      final others = sameCategoryList.where((account) => account.accountKeyID! != event.account.accountKeyID!).toList();
      // sort the accounts
      final sortedAccountList = [ first, ...others ]; // ... "spread operator" inserts multiple elements into a collection

      emit(state.copyWith(status: Status.success, accountList: sortedAccountList));
    } else {
      emit(state.copyWith(status: Status.error, message: TextString.empty));
    }
  }

  FutureOr<void> _onAccountsRefreshed(AccountsRefreshed event, Emitter<AccountsState> emit) {
    emit(state.copyWith(status: Status.loading));
    add(AccountsLoaded(event.account));
  }

  @override
  Future<void> close() async {
    _streamSubscription?.cancel();
    return super.close();
  }
}
