part of 'account_button_bloc.dart';

class AccountButtonState extends Equatable {
  const AccountButtonState({
    this.buttonList = const <HomeButton>[],
    this.status = Status.initial,
    this.message = ''
  });
  final List<HomeButton> buttonList;
  final Status status;
  final String message;

  AccountButtonState copyWith({
    List<HomeButton>? buttonList,
    Status? status,
    String? message
  }) {
    return AccountButtonState(
      buttonList: buttonList ?? this.buttonList,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [buttonList, status, message];
}
