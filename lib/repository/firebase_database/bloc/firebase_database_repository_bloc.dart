import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/repository/repository.dart';

part 'firebase_database_repository_event.dart';

class FirebaseDatabaseRepositoryBloc extends Bloc<FirebaseDatabaseRepositoryEvent, DisplayModel?> {
  FirebaseDatabaseRepositoryBloc({required this.repository}) : super(null) {
    on<GetDisplayEvent>(_onGetDisplayEvent);
  }
  final FirebaseDatabaseRepository repository;

  Future<void> _onGetDisplayEvent(GetDisplayEvent event, Emitter<DisplayModel?> emit) async {
    final display = await repository.getDisplay();
    emit(display!);
  }

}
