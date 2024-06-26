part of 'transfer_buttons_bloc.dart';

class TransferButtonsState extends Equatable {
  const TransferButtonsState({
    this.status = Status.initial,
    this.buttons = const <Button>[],
    this.message = ''
  });
  final Status status;
  final List<Button> buttons;
  final String message;

  TransferButtonsState copyWith({
    Status? status,
    List<Button>? buttons,
    String? message
  }) {
    return TransferButtonsState(
      status: status ?? this.status,
      buttons: buttons ?? this.buttons,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [status, buttons, message];
}
