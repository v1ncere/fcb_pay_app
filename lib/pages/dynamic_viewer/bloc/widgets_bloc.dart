import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'widgets_event.dart';
part 'widgets_state.dart';

class WidgetsBloc extends Bloc<WidgetsEvent, WidgetsState> {
  WidgetsBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
    required HiveRepository hiveRepository
  }) : _firebaseRepository = firebaseRepository,
  _hiveRepository = hiveRepository,
  super(const WidgetsState(widgetStatus: Status.loading)) {
    on<WidgetsLoaded>(_onWidgetsLoaded);
    on<WidgetsUpdated>(_onWidgetsUpdated);
    on<DynamicWidgetsValueChanged>(_onDynamicWidgetsValueChanged);
    on<AdditionalTextFieldValueChanged>(_onAdditionalTextFieldValueChanged);
    on<ButtonSubmitted>(_onButtonSubmitted);
  }
  final FirebaseRealtimeDBRepository _firebaseRepository;
  final HiveRepository _hiveRepository;
  StreamSubscription<List<HomeButtonWidget>>? _subscription;

  void _onWidgetsLoaded(WidgetsLoaded event, Emitter<WidgetsState> emit) {
    _subscription?.cancel();
    _subscription = _firebaseRepository
    .getWidgetsListStream(event.id)
    .listen((widgetList) async {
      add(WidgetsUpdated(widgetList));
    });
  }

  void _onWidgetsUpdated(WidgetsUpdated event, Emitter<WidgetsState> emit) async {
    if (event.widgetList.isEmpty) {
      emit(state.copyWith(
        widgetStatus: Status.error,
        errorMsg: 'Empty'
      ));
    } else {
      emit(state.copyWith(
        widgetStatus: Status.success,
        widgetList: event.widgetList
      ));
    }
  }

  void _onDynamicWidgetsValueChanged(DynamicWidgetsValueChanged event, Emitter<WidgetsState> emit) {
    // Find the index of the widget with a matching keyId in the widgetList.
    final index = state.widgetList.indexWhere((widget) => widget.keyId == event.keyId);
    // Check if a widget with a matching keyId was found.
    if (index != -1) {
      // Create a copy of the current widgetList to update.
      final updatedUserWidget = List<HomeButtonWidget>.from(state.widgetList);
      // Update the widget at the found index with the new content value.
      updatedUserWidget[index] = updatedUserWidget[index].copyWith(content: event.value); 

      // Emit a new state with the updated widgetList.
      emit(state.copyWith(widgetList: updatedUserWidget));
    }
  }

  void _onAdditionalTextFieldValueChanged(AdditionalTextFieldValueChanged event, Emitter<WidgetsState> emit) {

  }

  void _onButtonSubmitted(ButtonSubmitted event, Emitter<WidgetsState> emit) async {
    if (allDynamicTextFieldsValid()) {
      emit(state.copyWith(submissionStatus: Status.loading)); // emit loading

      String result = getFormSubmissionData().entries // all entries from the map
      .map((entries) => '${entries.key}:${entries.value.replaceAll(',', '')}') // return formatted entries into <key>:<value>
      .join(','); // join all entries into a string by comma (,)

      try {
        final id = await _firebaseRepository.addUserRequest(
          UserRequest(
            dataRequest: "button_title|$result",
            ownerId: FirebaseAuth.instance.currentUser!.uid,
            timeStamp: DateTime.now()
          )
        );

        _hiveRepository.addID(id!);
        emit(state.copyWith(submissionStatus: Status.success));
      } catch (e) {
        emit(state.copyWith(
          errorMsg: e.toString(),
          submissionStatus: Status.error
        ));
      }
    } else {
      emit(state.copyWith(
        errorMsg: "Incomplete Form: Please review the form and fill in all additional fields.",
        submissionStatus: Status.error
      ));
    }
  }

  bool allDynamicTextFieldsValid() {
    // regular expression for validating an [int] or [double with 2 decimal points]
    final regex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');

    // check if there's a [STRING TEXTFIELD] in the List<HomeButtonWidget>
    final stringTextFields = state.widgetList
    .where((widget) => widget.widget == 'textfield' && widget.dataType == 'string');
    // check if there's an [DOUBLE TEXTFIELD] in List<HomeButtonWidget>
    final doubleTextFields = state.widgetList
    .where((widget) => widget.widget == 'textfield' && widget.dataType == 'int');
    // check if there's a [STRING DROPDOWN] in List<HomeButtonWidget>
    final stringDropdown = state.widgetList
    .where((widget) => widget.widget == 'dropdown' && widget.dataType == 'string');
    // check if there's an [INT DROPDOWN] in List<HomeButtonWidget>
    final intDropdown = state.widgetList
    .where((widget) => widget.widget == 'dropdown' && widget.dataType == 'int');
    
    // check if (STRING TEXTFIELD) exists [OR] contains data
    final stringTextFieldsValid = stringTextFields.isEmpty || stringTextFields
    .every((widget) => widget.content?.isNotEmpty == true);
    // check if (DOUBLE TEXTFIELD) exists [OR] contains data [AND] is valid
    final doubleTextFieldsValid = doubleTextFields.isEmpty || doubleTextFields
    .every((widget) => widget.content?.isNotEmpty == true && regex.hasMatch(widget.content!));
    // check if (STRING DROPDOWN) exists [OR] contains data [AND] is valid
    final stringDropdownValid = stringDropdown.isEmpty || stringDropdown
    .every((dropdown) => dropdown.content?.isNotEmpty == true);
    // check if (INT DROPDOWN) exists [OR] contains data [AND] is valid
    final intDropdownValid = intDropdown.isEmpty || stringDropdown
    .every((dropdown) => dropdown.content?.isNotEmpty == true);

    return stringTextFieldsValid && doubleTextFieldsValid && stringDropdownValid && intDropdownValid;
  }

  // formatting Widget [content] into Map
  Map<String, String> getFormSubmissionData() {
    // declare map variable
    final Map<String, String> formData = {};

    // loop base on List<HomeButtonWidget> object
    for (final widget in state.widgetList) {
      if (widget.widget == "textfield" || widget.widget == "dropdown") {
        formData[widget.title!] = widget.content!; // store List<HomeButtonWidget> content into map
      }
    }
    return formData;
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    super.close();
  }
}
