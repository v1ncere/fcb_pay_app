import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../utils/utils.dart'; 

part 'widgets_event.dart';
part 'widgets_state.dart';

class WidgetsBloc extends Bloc<WidgetsEvent, WidgetsState> {
  WidgetsBloc({
    required FirebaseRealtimeDBRepository firebaseDatabase,
    required HiveRepository hiveRepository,
    required FirebaseAuthRepository firebaseAuth,
  }) : _firebaseRepository = firebaseDatabase,
  _firebaseAuth = firebaseAuth,
  _hiveRepository = hiveRepository,
  super(const WidgetsState(widgetStatus: Status.loading)) {
    on<WidgetsLoaded>(_onWidgetsLoaded);
    on<WidgetsUpdated>(_onWidgetsUpdated);
    on<ExtraWidgetFetched>(_onExtraWidgetFetched);
    on<DynamicWidgetsValueChanged>(_onDynamicWidgetsValueChanged);
    on<ExtraWidgetsValueChanged>(_onExtraWidgetValueChanged);
    //
    on<OtpTextChanged>(_onOtpTextChanged);
    on<PhoneNumberSent>(_onPhoneNumberSent);
    on<PhoneNumberResent>(_onPhoneNumberResent);
    on<PhoneOtpSent>(_onPhoneOtpSent);
    on<OtpVerified>(_onOtpVerified);
    on<PhoneAuthVerificationCompleted>(_onPhoneAuthVerificationCompleted);
    //
    on<PhoneAuthFailed>(_onPhoneAuthFailed);
    on<ButtonSubmitted>(_onButtonSubmitted);
  }
  final HiveRepository _hiveRepository;
  final FirebaseAuthRepository _firebaseAuth;
  final FirebaseRealtimeDBRepository _firebaseRepository;
  StreamSubscription<List<PageWidget>>? _subscription;

  // 'button' is the parent of the 'widget' on the dynamic display
  void _onWidgetsLoaded(WidgetsLoaded event, Emitter<WidgetsState> emit) {
    _subscription?.cancel();
    _subscription = _firebaseRepository
    .getWidgetsListStream(event.id) // get the widgets under that button
    .listen((widgetList) async {
      add(WidgetsUpdated(widgetList));
    });
  }

  // to notify the bloc that there is new event on the stream
  void _onWidgetsUpdated(WidgetsUpdated event, Emitter<WidgetsState> emit) async {
    if (event.widgetList.isNotEmpty) {
      List<PageWidget> widgetList = event.widgetList;
      bool hasData = await _dropdownHasData(widgetList);

      // get the button widget
      final buttonWidget = widgetList.firstWhere((e) => e.widget == 'button');
      // get the non button widgets
      final otherWidget = widgetList.where((e) => e.widget != 'button').toList();
      // sort widgets base on the [position]
      otherWidget.sort((a, b) => a.position.compareTo(b.position));
      // combine all the lists, put the button widget at the end of the list.
      final sortedWidgets = [...otherWidget, buttonWidget];
      // emit state
      emit(state.copyWith(widgetStatus: Status.success, widgetList: sortedWidgets, dropdownHasData: hasData));
    } else {
      emit(state.copyWith(widgetStatus: Status.error, message: TextString.empty));
    }
  }

  void _onExtraWidgetFetched(ExtraWidgetFetched event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(extraWidgetStatus: Status.loading));
    try {
      // get the extra widgets base on the intitution dropdown selection
      final extraWidgetList = await _firebaseRepository.getInstitutionExtraWidgetList(event.id);
      // sort the list base on position
      extraWidgetList.sort((a, b) => a.position.compareTo(b.position));
      // emit the extra widget to be displayed
      emit(state.copyWith(extraWidgetList: extraWidgetList, extraWidgetStatus: Status.success));
    } catch (err) {
      emit(state.copyWith(message: err.toString(), extraWidgetStatus: Status.error));
    }
  }

  void _onDynamicWidgetsValueChanged(DynamicWidgetsValueChanged event, Emitter<WidgetsState> emit) {
    // locate the [index] of the widget by matching the keyId in the widgetList.
    final index = state.widgetList.indexWhere((e) => e.keyId == event.keyId);
    // check if a widget with a matching keyId was found. [-1 means not found] 
    if (index != -1) {
      // create a copy of the current widgetList to update.
      final updatedUserWidget = List<PageWidget>.from(state.widgetList);
      // update the widget at the located index with the new content value.
      updatedUserWidget[index] = updatedUserWidget[index].copyWith(content: event.value); 
      // emit a new state with the updated widgetList.
      emit(state.copyWith(widgetList: updatedUserWidget));
    }
  }

  void _onExtraWidgetValueChanged(ExtraWidgetsValueChanged event, Emitter<WidgetsState> emit) {
    // locate the [index] of the widget by matching the keyId in the List.
    final index = state.extraWidgetList.indexWhere((e) => e.keyId == event.keyId);
    // check if a widget with a matching keyId was found. [-1 means not found] 
    if (index != -1) {
      // create a copy of the current List
      final updatedExtraWidget = List<ExtraWidget>.from(state.extraWidgetList);
      // update the widget at the located index with the new content value.
      updatedExtraWidget[index] = updatedExtraWidget[index].copyWith(content: event.value); 
      // emit a new state with the updated List.
      emit(state.copyWith(extraWidgetList: updatedExtraWidget));
    }
  } 

  // OTP INPUT TEXT CHANGED ====================================================
  void _onOtpTextChanged(OtpTextChanged event, Emitter<WidgetsState> emit) {
    emit(state.copyWith(pin: Pin.dirty(event.pin)));
  }

  // OTP PHONE NUMBER SENT
  Future<void> _onPhoneNumberSent(PhoneNumberSent event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.inProgress));
    await _firebaseAuth.phoneAuthentication(
      phoneNumber: FirebaseAuth.instance.currentUser?.phoneNumber ?? '',
      codeSent: (String verificationId, int? resendToken) async {
        add(PhoneOtpSent(verificationId: verificationId, resendToken: resendToken));          
      },
      codeAutoRetrievalTimeout: (_) {},
      verificationCompleted: (_) {},
      verificationFailed: (FirebaseAuthException e) {
        add(PhoneAuthFailed(e.message!));
      },
      timeout: const Duration(seconds: 90)
    );
  }

  // OTP PHONE NUMBER RESENT
  Future<void> _onPhoneNumberResent(PhoneNumberResent event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.inProgress));
    await _firebaseAuth.phoneAuthentication(
      phoneNumber: FirebaseAuth.instance.currentUser?.phoneNumber ?? '',
      forceResendingToken: state.resendToken,
      codeSent: (String verificationId, int? resendToken) async {
        add(PhoneOtpSent(verificationId: verificationId, resendToken: resendToken));          
      }, 
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (_) {},
      verificationCompleted: (_) {},
      verificationFailed: (FirebaseAuthException e) {
        add(PhoneAuthFailed(e.message!));
      },
    );
  }

  // OTP CODE SENT TRIGGERED
  Future<void> _onPhoneOtpSent(PhoneOtpSent event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.canceled, verificationId: event.verificationId, resendToken: event.resendToken));
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.initial));
  }

  // USER PRESS VERIFY
  Future<void> _onOtpVerified(OtpVerified event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.inProgress));
    final authCredential = _firebaseAuth.createPhoneAuthCredential(verificationId: state.verificationId, smsCode: state.pin.value);
    add(PhoneAuthVerificationCompleted(authCredential));
  }

  // OTP VERIFICATION PROCESS COMPLETED
  Future<void> _onPhoneAuthVerificationCompleted(PhoneAuthVerificationCompleted event, Emitter<WidgetsState> emit) async {
    try {
      await _firebaseAuth.signInWithAuthCredential(authCredential: event.authCredential).then((auth) {
        if (auth != null) {
          _otpSuccess(emit);
        }
      });
    } on FirebaseAuthenticationFailure catch (e) {
      _otpFailure(e.message, emit);
    } catch (e) {
      _otpFailure(e.toString(), emit);
    }
  }
  
  // OTP FAILURE
  void _onPhoneAuthFailed(PhoneAuthFailed event, Emitter<WidgetsState> emit) {
    _otpFailure(event.message, emit);
  }

  // OTP EMIT SUCCESS
  _otpSuccess(Emitter<WidgetsState> emit) {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.success));
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.initial));
  }

  // OTP EMIT FAILURE
  _otpFailure(String message, Emitter<WidgetsState> emit) {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.failure, message: message));
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.initial));
  }
  // OTP METHODS END ===========================================================

  FutureOr<void> _onButtonSubmitted(ButtonSubmitted event, Emitter<WidgetsState> emit) async {
    if(_areWidgetsValid(state.widgetList) && _areWidgetsValid(state.extraWidgetList)) {
      emit(state.copyWith(submissionStatus: Status.loading));
      try {
        String dynamicWidget = _widgetDataMap(state.widgetList)
        .entries.map((entries) { // all entries from the map
          return "${entries.key}:${entries.value.replaceAll(',', '')}"; // return formatted entries into <key>:<value> pair
        }).join(','); // join all entries into a string separated by a comma (",")

        String extraWidget = _widgetDataMap(state.extraWidgetList)
        .entries.map((entries) { // transfrom list into map
          return "${entries.key}:${entries.value.replaceAll(',', '')}"; // return  into key value pair
        }).join(','); // join all entries into a string separated by comma

        final dynamicWidgetsResult = _containsWidget(state.widgetList) ? '|$dynamicWidget' : '';
        final extraWidgetsResult = _containsWidget(state.extraWidgetList) ? '|$extraWidget' : '';

        // request title, 
        final reqTitle = event.title.trim().replaceAll(' ', '_').toLowerCase();
        // add request into firebase database
        final key = await _firebaseRepository.addUserRequest(
          UserRequest(
            dataRequest: '$reqTitle$dynamicWidgetsResult$extraWidgetsResult',
            extraData: '',
            ownerId: FirebaseAuth.instance.currentUser!.uid,
            timeStamp: DateTime.now()
          )
        );
        // id saved into local storage [hive] to locate receipt
        _hiveRepository.addId(key!);
        emit(state.copyWith(submissionStatus: Status.success));
      } catch (e) {
        emit(state.copyWith(submissionStatus: Status.error, message: e.toString()));
      }
    } else {
      emit(state.copyWith(submissionStatus: Status.error, message: TextString.incompleteForm));
    }
    emit(state.copyWith(submissionStatus: Status.initial));
  }

  // SECONDARY METHODS =========================================================
  // ===========================================================================
  
  // check if list contains 'textfield' or 'dropdown' widget
  bool _containsWidget<T extends dynamic>(List<T> list) {
    return list.any((e) => e.widget == 'textfield' || e.widget == 'dropdown');
  }

  // check all widgets if valid
  bool _areWidgetsValid<T extends dynamic>(List<T> list) {
    // regex for validating an [int] or [double with 2 decimal points]
    final regex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');
    // check if [STRING TEXTFIELD] match in the list
    final stringTextfield = list.where((e) => e.widget == 'textfield' && e.dataType == 'string');
    // check if [DOUBLE TEXTFIELD] match in the list
    final intTextfield = list.where((e) => e.widget == 'textfield' && e.dataType == 'int');
    // check if [STRING DROPDOWN] match in the list
    final stringDropdown = list.where((e) => e.widget == 'dropdown' && e.dataType == 'string');
    // check if [INT DROPDOWN] match in the list
    final intDropdown = list.where((e) => e.widget == 'dropdown' && e.dataType == 'int');
    // check if [STRING TEXTFIELD] exists [OR] contains data
    final isStringTextfieldValid = stringTextfield.isEmpty || stringTextfield.every((e) => e.content?.isNotEmpty == true);
    // check if [DOUBLE TEXTFIELD] exists [OR] contains data [AND] is valid [int/double]
    final isIntTextfieldValid = intTextfield.isEmpty || intTextfield.every((e) => e.content?.isNotEmpty == true && regex.hasMatch(e.content!));
    // check if [STRING DROPDOWN] exists [OR] contains data
    final isStringDropdownValid = stringDropdown.isEmpty || stringDropdown.every((e) => e.content?.isNotEmpty == true);
    // check if [INT DROPDOWN] exists [OR] contains data
    final isIntDropdownValid = intDropdown.isEmpty || intDropdown.every((e) => e.content?.isNotEmpty == true);
    // RETURN RESULT
    return isStringTextfieldValid && isIntTextfieldValid && isStringDropdownValid && isIntDropdownValid;
  }

  // formatting dynamic list [content] into Map
  Map<String, String> _widgetDataMap<T extends dynamic>(List<T> list) {
    // declare variable map
    final Map<String, String> map = {};
    // loop base on list
    for (final e in list) {
      if (e.widget == 'textfield' || e.widget == 'dropdown' || e.widget == 'multitextfield') {
        // store content into map
        map[e.title] = e.content!;
      }
    }
    // return result
    return map;
  }

  // check for empty dropdown data
  Future<bool> _dropdownHasData(List<PageWidget> widgetList) async {
    // mapped the widgetList for dropdown
    final dropdownList = widgetList.where((e) {
      return e.widget == 'dropdown' && !e.node.contains('user_account');
    }).toList();
    final id = FirebaseAuth.instance.currentUser!.uid;

    if (dropdownList.isNotEmpty) {
      for (final dropdown in dropdownList) {
        final ref = dropdown.node.replaceAll('{id}', id);
        if(ref.isNotEmpty) {
          final data = await _firebaseRepository.getDynamicListStringData(ref);
          if(data.isEmpty) {
            return false;
          }
        }
      }
    }

    return true;
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    super.close();
  }
}
