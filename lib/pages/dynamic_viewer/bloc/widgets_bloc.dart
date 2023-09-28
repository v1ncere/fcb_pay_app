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
  }) : _firebaseRepository = firebaseRepository, _hiveRepository = hiveRepository,
  super(const WidgetsState(widgetStatus: Status.loading)) {
    on<WidgetsLoaded>(_onWidgetsLoaded);
    on<WidgetsUpdated>(_onWidgetsUpdated);
    on<ExtraWidgetFetched>(_onExtraWidgetFetched);
    on<DynamicWidgetsValueChanged>(_onDynamicWidgetsValueChanged);
    on<ExtraWidgetsValueChanged>(_onExtraWidgetValueChanged);
    on<ButtonSubmitted>(_onButtonSubmitted);
    on<SubmissionStatusRefresher>(_onSubmissionStatusRefresher);
  }
  final HiveRepository _hiveRepository;
  final FirebaseRealtimeDBRepository _firebaseRepository;
  StreamSubscription<List<PageWidget>>? _subscription;

  void _onWidgetsLoaded(WidgetsLoaded event, Emitter<WidgetsState> emit) {
    _subscription?.cancel();
    _subscription = _firebaseRepository
    .getWidgetsListStream(event.id)
    .listen((widgetList) async {
      add(WidgetsUpdated(widgetList));
    });
  }

  void _onWidgetsUpdated(WidgetsUpdated event, Emitter<WidgetsState> emit) async {
    if (event.widgetList.isNotEmpty) {
      List<PageWidget> widgetList = event.widgetList;

      final buttonWidget = widgetList.firstWhere((widget) => widget.widget == 'button'); // get the button widget
      final otherWidget = widgetList.where((widget) => widget.widget != 'button').toList(); // get the non button widgets

      otherWidget.sort((a, b) => a.position.compareTo(b.position)); // sort widgets base on the [position] field
      final sortedWidgets = [...otherWidget, buttonWidget]; // combine otherWidget and buttonWidget, ensuring buttonWidget is at the end of the list.

      emit(state.copyWith(widgetStatus: Status.success, widgetList: sortedWidgets));
    } else {
      emit(state.copyWith(widgetStatus: Status.error, errorMsg: 'Empty'));
    }
  }

  void _onExtraWidgetFetched(ExtraWidgetFetched event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(extraWidgetStatus: Status.loading));
    try {
      final extraWidgetList = await _firebaseRepository.getExtraWidgetList(event.id);
      List<ExtraWidget> sortedExtraWidgets = extraWidgetList;
      sortedExtraWidgets.sort((a, b) => a.position.compareTo(b.position));
      
      emit(state.copyWith(
        extraWidgetList: sortedExtraWidgets,
        extraWidgetStatus: Status.success
      ));
    } catch (err) {
      emit(state.copyWith(
        errorMsg: err.toString(),
        extraWidgetStatus: Status.error
      ));
    }
  }

  void _onDynamicWidgetsValueChanged(DynamicWidgetsValueChanged event, Emitter<WidgetsState> emit) {
    // Find the index of the widget with a matching keyId in the widgetList.
    final index = state.widgetList.indexWhere((widget) => widget.keyId == event.keyId);
    // Check if a widget with a matching keyId was found.
    if (index != -1) {
      // Create a copy of the current widgetList to update.
      final updatedUserWidget = List<PageWidget>.from(state.widgetList);
      // Update the widget at the found index with the new content value.
      updatedUserWidget[index] = updatedUserWidget[index].copyWith(content: event.value); 

      // Emit a new state with the updated widgetList.
      emit(state.copyWith(widgetList: updatedUserWidget));
    }
  }

  void _onExtraWidgetValueChanged(ExtraWidgetsValueChanged event, Emitter<WidgetsState> emit) {
    final index = state.extraWidgetList.indexWhere((widget) => widget.keyId == event.keyId);
    
    if (index != -1) {
      final updatedExtraWidget = List<ExtraWidget>.from(state.extraWidgetList);
      updatedExtraWidget[index] = updatedExtraWidget[index].copyWith(content: event.value); 

      emit(state.copyWith(extraWidgetList: updatedExtraWidget));
    }
  }

  void _onSubmissionStatusRefresher(SubmissionStatusRefresher event, Emitter<WidgetsState> emit) {
    emit(state.copyWith(submissionStatus: Status.initial));
  }

  void _onButtonSubmitted(ButtonSubmitted event, Emitter<WidgetsState> emit) async {
    if (_allDynamicWidgetsValid() && _allExtraWidgetsValid()) {
      emit(state.copyWith(submissionStatus: Status.loading));

      String dynamicWidget = _dynamicWidgetSubmissionData().entries.map((entries) { // all entries from the map
        return "${entries.key}:${entries.value.replaceAll(',', '')}"; // return formatted entries into <key>:<value>
      }).join(","); // join all entries into a string by comma (",")

      String extraWidget = _extraWidgetSubmissionData().entries.map((entries) {
        return "${entries.key}:${entries.value.replaceAll(',', '')}";
      }).join(",");

      final dynamicWidgetsResult = _containsDynamicWidget()? '|$dynamicWidget' : "";
      final extraWidgetsResult = _containsExtraWidget() ? '|$extraWidget' : "";

      try {
        final reqTitle = event.title.trim().replaceAll(' ', '_').toLowerCase();
        final id = await _firebaseRepository.addUserRequest(
          UserRequest(
            dataRequest: '$reqTitle$dynamicWidgetsResult$extraWidgetsResult',
            ownerId: FirebaseAuth.instance.currentUser!.uid,
            timeStamp: DateTime.now()
          )
        );

        _hiveRepository.addID(id!);
        emit(state.copyWith(submissionStatus: Status.success, errorMsg: null));
      } catch (e) {
        emit(state.copyWith(errorMsg: e.toString(), submissionStatus: Status.error));
      }
    } else {
      emit(state.copyWith(
        errorMsg: "Incomplete Form: Please review the form and make sure all required fields are filled in correctly.",
        submissionStatus: Status.error
      ));
    }
  }

  bool _containsDynamicWidget() {
    return state.widgetList.any((widget) {
      return widget.widget == "textfield" || widget.widget == "dropdown";
    });
  }

  bool _containsExtraWidget() {
    return state.extraWidgetList.any((widget) {
      return widget.widget == "textfield" || widget.widget == "dropdown";
    });
  }

  bool _allDynamicWidgetsValid() {
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

  bool _allExtraWidgetsValid() {
    final regex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');

    final stringTextFields = state.extraWidgetList.where((widget) {
      return widget.widget == 'textfield' && widget.dataType == 'string';
    });
    final doubleTextFields = state.extraWidgetList.where((widget) {
      return widget.widget == 'textfield' && widget.dataType == 'int';
    });
    final stringDropdown = state.extraWidgetList.where((widget) {
      return widget.widget == 'dropdown' && widget.dataType == 'string';
    });
    final intDropdown = state.extraWidgetList.where((widget) {
      return widget.widget == 'dropdown' && widget.dataType == 'int';
    });
    
    final stringTextFieldsValid = stringTextFields.isEmpty || stringTextFields.every((widget) {
      return widget.content?.isNotEmpty == true;
    });
    final doubleTextFieldsValid = doubleTextFields.isEmpty || doubleTextFields.every((widget) {
      return widget.content?.isNotEmpty == true && regex.hasMatch(widget.content!);
    });
    final stringDropdownValid = stringDropdown.isEmpty || stringDropdown.every((dropdown) {
      return dropdown.content?.isNotEmpty == true;
    });
    final intDropdownValid = intDropdown.isEmpty || stringDropdown.every((dropdown) {
      return dropdown.content?.isNotEmpty == true;
    });

    return stringTextFieldsValid && doubleTextFieldsValid && stringDropdownValid && intDropdownValid;
  }

  // formatting Widget [content] into Map
  Map<String, String> _dynamicWidgetSubmissionData() {
    // declare map variable
    final Map<String, String> formData = {};

    // loop base on List<HomeButtonWidget> object
    for (final widget in state.widgetList) {
      if (widget.widget == "textfield" || widget.widget == "dropdown" || widget.widget == "multitextfield") {
        formData[widget.title] = widget.content!; // store List<PageWidget> content into map
      }
    }
    return formData;
  }

  Map<String, String> _extraWidgetSubmissionData() {
    // declare map variable
    final Map<String, String> extraWidgetList = {};

    // loop base on List<HomeButtonWidget> object
    for (final extra in state.extraWidgetList) {
      if (extra.widget == "textfield" || extra.widget == "dropdown" || extra.widget == "multitextfield") {
        extraWidgetList[extra.title] = extra.content!; // store List<ExtraWidget> content into map
      }
    }
    return extraWidgetList;
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    super.close();
  }
}
