import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';

part 'auth_checker_event.dart';
part 'auth_checker_state.dart';

class AuthCheckerBloc extends Bloc<AuthCheckerEvent, AuthCheckerState> {
  AuthCheckerBloc({
    required HivePinRepository hivePinRepository,
  }) : _hivePinRepository = hivePinRepository,
  super(const AuthCheckerState()) {
    on<AuthCheckerPinChecked>(_onAuthCheckerPinChecked);
  }
  final HivePinRepository _hivePinRepository;

  // check if pin exists
  void _onAuthCheckerPinChecked(AuthCheckerPinChecked event, Emitter<AuthCheckerState> emit) async {
    emit(state.copyWith(status: AuthCheckerStatus.loading));
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      final isExist = await _hivePinRepository.isPinAuthExist(uid);
      emit(state.copyWith(status: AuthCheckerStatus.success, isPinExist: isExist));
    } catch (_) {
      emit(state.copyWith(status: AuthCheckerStatus.failure));
    }
  }
}
