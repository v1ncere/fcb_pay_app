import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/pages/home_flow/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'router_event.dart';
part 'router_state.dart';

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc() : super(const RouterState.initial()) {
    on<RouterAccountsModelPassed>((event, emit) {
      emit(RouterState.accountsDynamic(event.accountModel));
    });
    
    on<RouterNotificationArgsPassed>((event, emit) {
      emit(RouterState.notificationViewer(event.args));
    });
    
    on<RouterDynamicButtonModelPassed>((event, emit) {
      emit(RouterState.dynamicPageViewer(event.buttonModel));
    });
    
    on<RouterAccountDynamicButtonModelPassed>((event, emit) {
      emit(RouterState.accountDynamicPageViewer(event.buttonModel));
    });
  }
}
