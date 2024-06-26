part of 'account_button_bloc.dart';

class AccountButtonState extends Equatable {
  const AccountButtonState({
    this.buttonList = const <Button>[],
    this.status = Status.initial,
    this.message = ''
  });
  final List<Button> buttonList;
  final Status status;
  final String message;

  AccountButtonState copyWith({
    List<Button>? buttonList,
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
