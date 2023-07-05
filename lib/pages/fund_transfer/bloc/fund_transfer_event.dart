part of 'fund_transfer_bloc.dart';

abstract class FundTransferEvent extends Equatable {
  const FundTransferEvent();

  @override
  List<Object> get props => [];
}

class AmountChanged extends FundTransferEvent {
  const AmountChanged(this.amount);
  final String amount;

  @override
  List<Object> get props => [amount];
}

class SourceAccountChanged extends FundTransferEvent {
  const SourceAccountChanged(this.source);
  final String source;

  @override
  List<Object> get props => [source];
}

class RecipientAccountChanged extends FundTransferEvent {
  const RecipientAccountChanged(this.recipient);
  final String recipient;

  @override
  List<Object> get props => [recipient];
}

class MessageChanged extends FundTransferEvent {
  const MessageChanged(this.messages);
  final String messages;

  @override
  List<Object> get props => [messages];
}

class FundTransferSubmitted extends FundTransferEvent {
  const FundTransferSubmitted(this.account);
  final String account;

  @override
  List<Object> get props => [account];
}
