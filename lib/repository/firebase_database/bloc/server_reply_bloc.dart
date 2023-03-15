import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/repository/repository.dart';

part 'server_reply_event.dart';
part 'server_reply_state.dart';

class ServerReplyBloc extends Bloc<ServerReplyEvent, ServerReplyState> {
  final FirebaseDatabaseRepository _firebaseDatabaseRepository;
  final HiveServerReplyRepository _hiveServerReplyRepository;
  ServerReplyBloc({
    required FirebaseDatabaseRepository firebaseDatabaseRepository,
    required HiveServerReplyRepository hiveServerReplyRepository,
  }): _firebaseDatabaseRepository = firebaseDatabaseRepository,
      _hiveServerReplyRepository = hiveServerReplyRepository,
      super(ServerReplyLoading()) {
        on<ServerReplyLoaded>(_onServerReplyLoaded);
        on<ServerReplyUpdated>(_onServerReplyUpdated);
      }
  
  void _onServerReplyLoaded(ServerReplyLoaded event, Emitter<ServerReplyState> emit) async {
    final replyModel = await _firebaseDatabaseRepository.getServerReply();
    
    add(ServerReplyUpdated(replyModel));
  }

  void _onServerReplyUpdated(ServerReplyUpdated event, Emitter<ServerReplyState> emit) async {
    await _hiveServerReplyRepository.addServerReply(event.serverReply!);
    
    emit(ServerReplyLoad(serverReply: event.serverReply!));
  }
}
