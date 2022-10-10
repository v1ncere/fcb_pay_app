import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/repository/model/account.dart';
import 'package:fcb_pay_app/repository/account_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AccountRepository accountRepository;
  
  HomeBloc({required this.accountRepository}) : super(HomeInitial()) {
    // on<Create>(_createEventToState);
    on<GetData>((event, emit) async {
      emit(AccountLoading());
      try {
        final data = await accountRepository.getData();
        emit(AccountLoaded(data));
      } catch (e) {
        emit(AccountError(e.toString()));
      }
    });
  }

  // void _createEventToState(Create event, Emitter<HomeState> emit) async {
  //   emit(AccountAdding());
  //   await Future.delayed(const Duration(microseconds: 1000));

  //   try {
  //     await accountRepository.create(
  //       account: event.account,
  //       balance: event.balance,
  //       walletBalance: event.walletBalance
  //     );
  //     emit(AccountAdded());
  //   } catch (e) {
  //     emit(AccountError(e.toString()));
  //   }
  // }

}
