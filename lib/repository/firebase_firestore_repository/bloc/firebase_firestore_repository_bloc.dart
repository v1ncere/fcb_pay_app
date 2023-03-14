import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/repository/repository.dart';

part 'firebase_firestore_repository_event.dart';
part 'firebase_firestore_repository_state.dart';

class FirebaseFirestoreRepositoryBloc extends Bloc<FirebaseFirestoreRepositoryEvent, FirebaseFirestoreRepositoryState> {
  final FirebaseFirestoreRepository _accountRepository;
  final HiveRepository _hiveRepository;
  StreamSubscription? _streamSubscription;

  FirebaseFirestoreRepositoryBloc({
    required FirebaseFirestoreRepository firebaseFirestoreRepository,
    required HiveRepository hiveRepository,
  }): _accountRepository = firebaseFirestoreRepository,
      _hiveRepository = hiveRepository,
      super(AccountLoading()) {
        on<LoadAccounts>(_loadAccounts);
        on<UpdateAccounts>(_updateAccounts);
      }

  void _loadAccounts(LoadAccounts event, Emitter<FirebaseFirestoreRepositoryState> emit) async {
    _streamSubscription?.cancel();
    _streamSubscription = _accountRepository.getAllAccount()
    .listen((accounts) async {
      add(UpdateAccounts(accounts));
    });
  }

  // need to load accounts
  void _updateAccounts(UpdateAccounts event, Emitter<FirebaseFirestoreRepositoryState> emit) async {
    for (var element in event.accounts) {
      await _hiveRepository.putAccount(element);
    }
    emit(AccountLoad(account: event.accounts));
  }
}
