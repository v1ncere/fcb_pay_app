part of 'account_settings_bloc.dart';

class AccountSettingsState extends Equatable {
  const AccountSettingsState({
    this.status = Status.initial,
    this.message = ''
  });
  final String message;
  final Status status;

  AccountSettingsState copyWith({
    String? message,
    Status? status
  }) {
    return AccountSettingsState(
      message: message ?? this.message,
      status: status ?? this.status
    );
  }
  
  @override
  List<Object> get props => [status, message];
}
