import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/repository/repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.authenticationRepository) : super(const SettingsState());
  final FirebaseAuthRepository authenticationRepository;

  Future<void> logOut() async {
    authenticationRepository.logOut();
  }
}