part of 'transfer_buttons_bloc.dart';

sealed class TransferButtonsEvent extends Equatable {
  const TransferButtonsEvent();

  @override
  List<Object> get props => [];
}

final class TransferButtonsLoaded extends TransferButtonsEvent {}

final class TransferButtonsUpdated extends TransferButtonsEvent {
  const TransferButtonsUpdated(this.buttonList);
  final List<Button> buttonList;

  @override
  List<Object> get props => [];
}

final class TransferButtonsRefreshed extends TransferButtonsEvent {}