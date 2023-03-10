import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/repository/repository.dart';

part 'home_webview_event.dart';
part 'home_webview_state.dart';

class HomeWebviewBloc extends Bloc<HomeWebviewEvent, HomeWebviewState> {
  HomeWebviewBloc({required this.firebaseDatabaseRepository}) : super(HomeWebviewLoading()) {
    on<HomeWebviewLoadRequested>(_onHomeWebviewLoadRequested);
  }
  final FirebaseDatabaseRepository firebaseDatabaseRepository;

  void _onHomeWebviewLoadRequested(HomeWebviewLoadRequested event, Emitter<HomeWebviewState> emit) async {
    emit(HomeWebviewLoading());
    try {
      final displayModel = await firebaseDatabaseRepository.getDisplay();
      emit(HomeWebviewLoaded(displayModel!));
    } catch (e) {
      emit(HomeWebviewLoadFailure(e.toString()));
    }
  }
}
