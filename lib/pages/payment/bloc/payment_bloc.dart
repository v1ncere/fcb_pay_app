import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:hive_repository/hive_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
    required HiveRepository hiveRepository
  }) : _realtimeDBRepository = firebaseRealtimeDBRepository,
  _hiveRepository = hiveRepository,
  super(const PaymentState()) {
    on<InstitutionValueChanged>(_onInstitutionSelectionChanged);
    on<AccountValueChanged>(_onAccountSelectionChanged);
    on<UserWidgetFetched>(_onUserWidgetFetched);
    on<AmountTextFieldChanged>(_onPaymentTransactionAmountChanged);
    on<AdditionalTextFieldValueChanged>(_onAdditionalTextFieldValueChanged);
    on<AdditionalFieldDisplayed>(_onAdditionalFieldDisplayed);
    on<PaymentSubmitted>(_onPaymentSubmitted);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  final HiveRepository _hiveRepository;

  void _onUserWidgetFetched(UserWidgetFetched event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<UserWidget> widgets = await _realtimeDBRepository.getUserWidgetList(event.select);
      emit(state.copyWith(
        widgetList: widgets,
        status: Status.success
      ));
    } catch (e) {
      emit(state.copyWith(
        message: e.toString(),
        status: Status.error
      ));
    }
  }

  void _onPaymentTransactionAmountChanged(AmountTextFieldChanged event, Emitter<PaymentState> emit) {
    final amount = Amount.dirty(event.amount);
    emit(state.copyWith(amount: amount));
  }

  void _onInstitutionSelectionChanged(InstitutionValueChanged event, Emitter<PaymentState> emit) {
    final institution = InstitutionDropdown.dirty(event.institution);
    emit(state.copyWith(institutionDropdown: institution));
  }

  void _onAccountSelectionChanged(AccountValueChanged event, Emitter<PaymentState> emit) {
    final account = AccountDropdown.dirty(event.account);
    emit(state.copyWith(accountDropdown: account));
  }

  void _onAdditionalTextFieldValueChanged(AdditionalTextFieldValueChanged event, Emitter<PaymentState> emit) {
    final updatedWidgetList = List<UserWidget>.from(state.widgetList);
    final index = updatedWidgetList.indexWhere((widget) => widget.keyId == event.keyId);
    
    if (index != -1) {
      final updatedUserWidgets = List<UserWidget>.from(updatedWidgetList);
      final widget = updatedUserWidgets[index].copyWith(content: event.value);
      updatedUserWidgets[index] = widget;

      emit(state.copyWith(widgetList: updatedUserWidgets));
    }
  }

  void _onAdditionalFieldDisplayed(AdditionalFieldDisplayed event, Emitter<PaymentState> emit) {
    String result = getFormSubmissionData().entries
      .map((entries) => '${entries.key} : ${entries.value}')
      .join("\n");

    emit(state.copyWith(additional: result));
  }

  Future<void> _onPaymentSubmitted(PaymentSubmitted event, Emitter<PaymentState> emit) async {
    String result = getFormSubmissionData().entries
    .map((entries) => '${entries.key}:${entries.value}')
    .join(',');
    
    final fields = containsTextField() ? '|$result': '';
    final account = event.account.isEmpty
    ? state.accountDropdown.value?.replaceAll(' ', '')
    : event.account.replaceAll(' ', '');

    if (state.isValid) {
      if (!containsTextField() || (containsTextField() && hasUserInputInTextFields())) {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress)); // emit loading

        try {
          final id = await _realtimeDBRepository.addUserRequest(
            UserRequest(
              dataRequest: "bills_payment|$account|${state.institutionDropdown.value}|${state.amount.value}$fields",
              ownerId: FirebaseAuth.instance.currentUser!.uid,
              timeStamp: DateTime.now()
            )
          );

          _hiveRepository.addID(id!);
          emit(state.copyWith(formStatus: FormzSubmissionStatus.success));
        } catch (e) {
          emit(state.copyWith(
            message: e.toString(),
            formStatus: FormzSubmissionStatus.failure
          ));
        }
      } else {
        emit(state.copyWith(
          message: "Incomplete Form: Please review the form and fill in all additional fields.",
          formStatus: FormzSubmissionStatus.failure
        ));
      }
    } else {
      emit(state.copyWith(
        message: "Incomplete Form: Please review the form and fill in all required fields.",
        formStatus: FormzSubmissionStatus.failure
      ));
    }
  }

  bool containsTextField() {
    return state.widgetList.any((widget) => widget.widget == "textfield");
  }

  bool hasUserInputInTextFields() {
    return state.widgetList // list of object UserWidget
    .where((userWidget) => userWidget.widget == "textfield") // filter only the textfield
    .every((widget) => widget.content?.isNotEmpty == true); // check all textfields if empty
  }

  Map<String, String> getFormSubmissionData() {
    final Map<String, String> formData = {};

    for (final userWidget in state.widgetList) {
      if (userWidget.widget == 'textfield') {
        formData[userWidget.title] = userWidget.content!;
      }
    }
    return formData;
  }
}
