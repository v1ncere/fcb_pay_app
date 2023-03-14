import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/repository/repository.dart';

part 'firebase_database_reply_event.dart';
part 'firebase_database_reply_state.dart';

class FirebaseDatabaseReplyBloc extends Bloc<FirebaseDatabaseReplyEvent, FirebaseDatabaseReplyState> {
  FirebaseDatabaseReplyBloc() : super(ReplyLoading()) {
    on<FirebaseDatabaseReplyEvent>((event, emit) {
      
    });
  }
}
