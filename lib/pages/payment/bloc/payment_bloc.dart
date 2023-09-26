import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
    required HiveRepository hiveRepository
  }) : _realtimeDBRepository = firebaseRepository,
  _hiveRepository = hiveRepository,
  super(const PaymentState()) {
    on<InstitutionValueChanged>(_onInstitutionSelectionChanged);
    on<AccountValueChanged>(_onAccountSelectionChanged);
    on<UserWidgetFetched>(_onUserWidgetFetched);
    on<AmountTextFieldChanged>(_onPaymentTransactionAmountChanged);
    on<AdditionalTextFieldValueChanged>(_onAdditionalTextFieldValueChanged);
    on<PaymentSubmitted>(_onPaymentSubmitted);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  final HiveRepository _hiveRepository;

  void _onUserWidgetFetched(UserWidgetFetched event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<ExtraWidget> widgets = await _realtimeDBRepository.getExtraWidgetList(event.select);
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
    final index = state.widgetList.indexWhere((widget) => widget.keyId == event.keyId); // finding the [index] base on [keyId]

    if (index != -1) {
      final updatedUserWidget = List<ExtraWidget>.from(state.widgetList); // copy of List<UserWidget> object to avoid direct modification of the original
      updatedUserWidget[index] = updatedUserWidget[index].copyWith(content: event.value); // update UserWidget with new content

      emit(state.copyWith(widgetList: updatedUserWidget)); // emit updated widgetList
    }
  }

  Future<void> _onPaymentSubmitted(PaymentSubmitted event, Emitter<PaymentState> emit) async {
    if (state.isValid) {
      if (allDynamicTextFieldsValid()) {
        emit(state.copyWith(formzStatus: FormzSubmissionStatus.inProgress)); // emit loading

        String result = getFormSubmissionData().entries // all entries from the map
        .map((entries) => '${entries.key}:${entries.value.replaceAll(',', '')}') // return formatted entries into <key>:<value>
        .join(','); // join all entries into a string by comma ,
      
        final fields = containsTextField() ? '|$result': '';
        final account = event.account.isEmpty
        ? state.accountDropdown.value?.replaceAll(' ', '')
        : event.account.replaceAll(' ', '');

        try {
          final id = await _realtimeDBRepository.addUserRequest(
            UserRequest(
              dataRequest: "bills_payment|$account|${state.institutionDropdown.value}|${state.amount.value}$fields",
              ownerId: FirebaseAuth.instance.currentUser!.uid,
              timeStamp: DateTime.now()
            )
          );

          _hiveRepository.addID(id!);
          emit(state.copyWith(formzStatus: FormzSubmissionStatus.success));
        } catch (e) {
          emit(state.copyWith(
            message: e.toString(),
            formzStatus: FormzSubmissionStatus.failure
          ));
        }
      } else {
        emit(state.copyWith(
          message: "Incomplete Form: Please review the form and fill in all additional fields.",
          formzStatus: FormzSubmissionStatus.failure
        ));
      }
    } else {
      emit(state.copyWith(
        message: "Incomplete Form: Please review the form and fill in all required fields.",
        formzStatus: FormzSubmissionStatus.failure
      ));
    }
  }

  bool containsTextField() {
    return state.widgetList.any((widget) => widget.widget == "textfield");
  }

  bool allDynamicTextFieldsValid() {
    // regular expression for validating an [int] or [double with 2 decimal points]
    final regex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');

    // check if there's string textfield
    final stringTextFields = state.widgetList
    .where((userWidget) => userWidget.widget == 'textfield' && userWidget.dataType == 'string');
    // check if there's int textfield
    final intTextFields = state.widgetList
    .where((userWidget) => userWidget.widget == 'textfield' && userWidget.dataType == 'int');
    // check if string textfield exists OR contains data
    final stringTextFieldsValid = stringTextFields.isEmpty || stringTextFields
    .every((widget) => widget.content?.isNotEmpty == true);
    // check if int textfield exists OR contains data AND is valid
    final intTextFieldsValid = intTextFields.isEmpty || intTextFields
    .every((widget) => widget.content?.isNotEmpty == true && regex.hasMatch(widget.content!));

    return stringTextFieldsValid && intTextFieldsValid;
  }

  // formatting UserWidget [content] into map
  Map<String, String> getFormSubmissionData() {
    // declare map variable
    final Map<String, String> formData = {};

    // loop base on List<UserWidget> object
    for (final userWidget in state.widgetList) {
      if (userWidget.widget == 'textfield') {
        formData[userWidget.title] = userWidget.content!; // store List<UserWidget> content into map
      }
    }
    return formData;
  }
}
