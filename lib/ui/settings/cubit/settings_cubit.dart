import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/repository/authentication_repository/authentication_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.authenticationRepository) : super(const SettingsState());
  final AuthenticationRepository authenticationRepository;

  Future<void> logOut() async {
    authenticationRepository.logOut();
  }
}