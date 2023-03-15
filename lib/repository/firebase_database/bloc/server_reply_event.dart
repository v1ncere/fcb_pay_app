part of 'server_reply_bloc.dart';

abstract class ServerReplyEvent extends Equatable {
  const ServerReplyEvent();

  @override
  List<Object> get props => [];
}

class ServerReplyLoaded extends ServerReplyEvent {}

class ServerReplyUpdated extends ServerReplyEvent {
  const ServerReplyUpdated(this.serverReply);
  final ServerReply? serverReply;

  @override
  List<Object> get props => [serverReply!];
}