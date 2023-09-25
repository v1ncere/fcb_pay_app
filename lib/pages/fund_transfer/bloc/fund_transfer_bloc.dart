import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:hive_repository/hive_repository.dart';

part 'fund_transfer_event.dart';
part 'fund_transfer_state.dart';

class FundTransferBloc extends Bloc<FundTransferEvent, FundTransferState> {
  FundTransferBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
    required HiveRepository hiveRepository
  })  : _realtimeDBRepository = firebaseRepository, _hiveRepository = hiveRepository,
  super(const FundTransferState()) {
    on<AmountChanged>(_onAmountChanged);
    on<SourceAccountChanged>(_onSourceAccountChanged);
    on<RecipientAccountChanged>(_onRecipientAccountChanged);
    on<MessageChanged>(_onMessageChanged);
    on<FundTransferSubmitted>(_onFundTransferSubmitted);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  final HiveRepository _hiveRepository;

  void _onAmountChanged(AmountChanged event, Emitter<FundTransferState> emit){
    final amount = Amount.dirty(event.amount);
    emit(state.copyWith(amount: amount));
  }

  void _onSourceAccountChanged(SourceAccountChanged event, Emitter<FundTransferState> emit){
    final source = AccountDropdown.dirty(event.source);
    emit(state.copyWith(sourceDropdown: source));
  }

  void _onRecipientAccountChanged(RecipientAccountChanged event, Emitter<FundTransferState> emit){
    final recipient = AccountDropdown.dirty(event.recipient);
    emit(state.copyWith(recipientDropdown: recipient));
  }

  void _onMessageChanged(MessageChanged event, Emitter<FundTransferState> emit){
    final message = Message.dirty(event.messages);
    emit(state.copyWith(message: message));
  }

  Future<void> _onFundTransferSubmitted(FundTransferSubmitted event, Emitter<FundTransferState> emit) async{
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress)); // emit loading

      final account = event.account.isNotEmpty ? event.account : state.sourceDropdown.value;
      final message = state.message.value != '' ? '|${state.message.value}' : '';

      try {
        final id = await _realtimeDBRepository.addUserRequest(
          UserRequest(
            dataRequest: 'fund_transfer|$account|${state.recipientDropdown.value}|${state.amount.value}$message',
            ownerId: FirebaseAuth.instance.currentUser!.uid,
            timeStamp: DateTime.now()
          )
        );

        _hiveRepository.addID(id!); // store [id] to hive (local DB) to get receipt
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        throw Exception(e.toString);
      }
    } else {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        error: "Incomplete Form: Please review the form and fill in all required fields."
      ));
    }
  }
}
