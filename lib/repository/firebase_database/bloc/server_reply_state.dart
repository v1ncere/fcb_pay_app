part of 'server_reply_bloc.dart';

abstract class ServerReplyState extends Equatable {
  const ServerReplyState();
  
  @override
  List<Object> get props => [];
}

class ServerReplyLoading extends ServerReplyState {}

class ServerReplyLoad extends ServerReplyState {
  const ServerReplyLoad({required this.serverReply});
  final ServerReply serverReply;

  @override
  List<Object> get props => [serverReply];
}