import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

part 'account_settings_event.dart';
part 'account_settings_state.dart';

class AccountSettingsBloc extends Bloc<AccountSettingsEvent, AccountSettingsState> {
  AccountSettingsBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _firebaseRepository = firebaseRepository,
  super(const AccountSettingsState()) {
    on<AccountEventPressed>(_onAccountsDeleted);
  }
  final FirebaseRealtimeDBRepository _firebaseRepository;

  void _onAccountsDeleted(AccountEventPressed event, Emitter<AccountSettingsState> emit) async {
    emit(state.copyWith(status: Status.initial));

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final account = event.account;
      final method = event.method.toLowerCase();

      _firebaseRepository.addUserRequest(
        UserRequest(
          dataRequest: '${method}_account|$uid|$account',
          extraData: '',
          ownerId: uid,
          timeStamp: DateTime.now()
        )
      );

      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.error, message: e.toString()));
    }
  }
}
