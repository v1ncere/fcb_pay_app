import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_repository/firebase_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends HydratedBloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required FirebaseRealtimeDBRepository firebaseDatabaseRepository,
    required FirebaseAuthRepository firebaseAuthRepository,
    required FirebaseStorageRepository firebaseStorageRepository,
  }) : _firebaseDatabase = firebaseDatabaseRepository,
  _firebaseAuth = firebaseAuthRepository,
  _firebaseStorage = firebaseStorageRepository,
  super(
    SignUpState(
      emailController: TextEditingController(),
      firstNameController: TextEditingController(),
      lastNameController: TextEditingController(),
      mobileController: TextEditingController(),
      passwordController: TextEditingController(),
      confirmPasswordController: TextEditingController(),
    )
  ) {
    on<EmailChanged>(_onEmailChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<UserImageChanged>(_onUserImageChanged);
    //
    on<LostDataRetrieved>(_onLostDataRetrieved);
    //
    on<EmailTextErased>(_onEmailTextErased);
    on<FirstNameTextErased>(_onFirstNameTextErased);
    on<LastNameTextErased>(_onLastNameTextErased);
    on<MobileTextErased>(_onMobileTextErased);
    on<PasswordTextErased>(_onPasswordTextErased);
    on<ConfirmPasswordTextErased>(_onConfirmPasswordTextErased);
    //
    on<PasswordObscured>(_onPasswordObscured);
    on<ConfirmPasswordObscured>(_onConfirmPasswordObscured);
    //
    on<OtpTextChanged>(_onOtpTextChanged);
    on<PhoneNumberSent>(_onPhoneNumberSent);
    on<PhoneNumberResent>(_onPhoneNumberResent);
    on<PhoneOtpSent>(_onPhoneOtpSent);
    on<OtpVerified>(_onOtpVerified);
    on<PhoneAuthVerificationCompleted>(_onPhoneAuthVerificationCompleted);
    //
    on<PhoneAuthFailed>(_onPhoneAuthFailed);
    on<FormSubmissionFailed>(_onFormSubmissionFailed);
    //
    on<FormSubmitted>(_onFormSubmitted);
    on<UserDetailsAdded>(_onUserDetailsAdded);
    on<UploadImageProgressed>(_onUploadImageProgressed);
    on<HydrateStateChanged>(_onHydrateStateChanged);
  }
  final FirebaseRealtimeDBRepository _firebaseDatabase;
  final FirebaseStorageRepository _firebaseStorage;
  final FirebaseAuthRepository _firebaseAuth;
  //
  final TextRecognizer textRecognizer = TextRecognizer();
  final ImagePicker _picker = ImagePicker();

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: Email.dirty(event.email)));
  }
  
  void _onFirstNameChanged(FirstNameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(firstName: Name.dirty(event.firstName)));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(lastName: Name.dirty(event.lastName)));
  }

  void _onMobileNumberChanged(MobileNumberChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(mobile: MobileNumber.dirty(event.mobile)));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: Password.dirty(event.password)));
  }

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(confirmPassword: ConfirmedPassword.dirty(password: event.password, value: event.confirmPassword)));
  }

  Future<void> _onUserImageChanged(UserImageChanged event, Emitter<SignUpState> emit) async {
    try {
      emit(state.copyWith(userImageStatus: Status.loading));
      if (await _isScannedTextExists(event.image)) {
        emit(state.copyWith(userImageStatus: Status.success, userImage: event.image));
      } else {
        emit(state.copyWith(userImageStatus: Status.error, message: 'Image is not a valid FCB Pitakard'));
      }
    } catch (e) {
      emit(state.copyWith(userImageStatus: Status.error, message: e.toString()));
    }
  }

  Future<void> _onLostDataRetrieved(LostDataRetrieved events, Emitter<SignUpState> emit) async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    emit(state.copyWith(userImageStatus: Status.loading));
    if (response.file != null) {
      if (await _isScannedTextExists(response.file!)) {
        emit(state.copyWith(userImageStatus: Status.success, userImage: response.file));
      } else {
        emit(state.copyWith(userImageStatus: Status.error, message: 'Image is not a valid FCB Pitakard'));
      }
    } else {
      emit(state.copyWith(userImageStatus: Status.error, message: response.exception!.code));
    }
  }

  void _onEmailTextErased(EmailTextErased event, Emitter<SignUpState> emit) {
    state.emailController.clear();
    emit(state.copyWith(email: const Email.pure()));
  }

  void _onFirstNameTextErased(FirstNameTextErased event, Emitter<SignUpState> emit) {
    state.firstNameController.clear();
    emit(state.copyWith(firstName: const Name.pure()));
  }

  void _onLastNameTextErased(LastNameTextErased event, Emitter<SignUpState> emit) {
    state.lastNameController.clear();
    emit(state.copyWith(lastName: const Name.pure()));
  }

  void _onMobileTextErased(MobileTextErased event, Emitter<SignUpState> emit) {
    state.mobileController.clear();
    emit(state.copyWith(mobile: const MobileNumber.pure()));
  }

  void _onPasswordTextErased(PasswordTextErased event, Emitter<SignUpState> emit) {
    state.passwordController.clear();
    emit(state.copyWith(password: const Password.pure()));
  }

  void _onConfirmPasswordTextErased(ConfirmPasswordTextErased event, Emitter<SignUpState> emit) {
    state.confirmPasswordController.clear();
    emit(state.copyWith(confirmPassword: const ConfirmedPassword.pure(password: '')));
  }

  void _onPasswordObscured(PasswordObscured event, Emitter<SignUpState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onConfirmPasswordObscured(ConfirmPasswordObscured event, Emitter<SignUpState> emit) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword)); 
  }

  // OTP INPUT TEXT CHANGED ====================================================
  void _onOtpTextChanged(OtpTextChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(pin: Pin.dirty(event.pin)));
  }

  // OTP PHONE NUMBER SENT
  Future<void> _onPhoneNumberSent(PhoneNumberSent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.inProgress));
    await _firebaseAuth.phoneAuthentication(
      phoneNumber: event.phoneNumber,
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
  Future<void> _onPhoneNumberResent(PhoneNumberResent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.inProgress));
    await _firebaseAuth.phoneAuthentication(
      phoneNumber: '+63${state.mobile.value.trim()}',
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
  Future<void> _onPhoneOtpSent(PhoneOtpSent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.canceled, verificationId: event.verificationId, resendToken: event.resendToken));
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.initial));
  }

  // USER PRESS VERIFY
  Future<void> _onOtpVerified(OtpVerified event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.inProgress));
    final authCredential = _firebaseAuth.createPhoneAuthCredential(verificationId: event.verificationId, smsCode: event.smsCode);
    add(PhoneAuthVerificationCompleted(authCredential));
   }

  // OTP VERIFICATION PROCESS COMPLETED
  Future<void> _onPhoneAuthVerificationCompleted(PhoneAuthVerificationCompleted event, Emitter<SignUpState> emit) async {
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
  void _onPhoneAuthFailed(PhoneAuthFailed event, Emitter<SignUpState> emit) {
    _otpFailure(event.message, emit);
  }

  // OTP EMIT SUCCESS
  _otpSuccess(Emitter<SignUpState> emit) {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.success));
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.initial));
  }

  // OTP EMIT FAILURE
  _otpFailure(String message, Emitter<SignUpState> emit) {
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.failure, message: message));
    emit(state.copyWith(otpStatus: FormzSubmissionStatus.initial));
  }
  // OTP METHODS END ===========================================================

  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<SignUpState> emit) async {
    try {
      // emit progress state
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      // email and password credential
      final authCredential = _firebaseAuth.emailAndPasswordAuthCredential(email: state.email.value, password: state.password.value);
      // link authCredential to PhoneAuth
      final user = await _firebaseAuth.linkWithCredential(authCredential: authCredential);
      if (user != null) {
        await _firebaseAuth.verifyEmail();
        _firebaseStorage
        .addImageReturnUploadTask(state.userImage)
        .snapshotEvents
        .listen((TaskSnapshot snapshot) async {
          switch (snapshot.state) {
            case TaskState.running:
              final progress = snapshot.bytesTransferred / snapshot.totalBytes;
              add(UploadImageProgressed(progress));
              break;
            case TaskState.paused:
              break;
            case TaskState.canceled:
              break;
            case TaskState.error:
              add(const FormSubmissionFailed('upload data error'));
              break;
            case TaskState.success:
              final url = await snapshot.ref.getDownloadURL();
              add(UserDetailsAdded(url));
              break;
          }
        });
      }
    } on FirebaseAuthenticationFailure catch (e) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onUserDetailsAdded(UserDetailsAdded event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.initial));
    try {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      await _firebaseDatabase.addUserDetails(
        UserDetails(
          email: state.email.value, 
          firstName: state.firstName.value,
          lastName: state.lastName.value,
          mobile: int.parse('63${state.mobile.value}'),
          userImageUrl: event.url,
          timeStamp: DateTime.now()
        )
      ).then((id) {
        add(const HydrateStateChanged(isHydrated: false));
        emit(state.copyWith(formStatus: FormzSubmissionStatus.success, message: TextString.verifyRequest));
      });
    } catch (e) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.toString()));
    }
    unawaited(_firebaseAuth.logOut());
  }

  void _onUploadImageProgressed(UploadImageProgressed event, Emitter<SignUpState> emit) {
    emit(state.copyWith(progress: event.progress));
  }

  void _onFormSubmissionFailed(FormSubmissionFailed event, Emitter<SignUpState> emit) {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: event.error));
  }

  void _onHydrateStateChanged(HydrateStateChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(hydratedStatus: event.isHydrated));
  }

  // UTILITY METHODS ===========================================================

  Future<bool> _isScannedTextExists(XFile image) async {
    final recognizedText = await textRecognizer.processImage(InputImage.fromFilePath(image.path));
    await textRecognizer.close();
    final fcb = _isTextExist(recognizedText, 'FIRST CONSOLIDATED BANK');
    final pitakard = _isTextExist(recognizedText, 'PITAKArd');
    final account = _isTextExist(recognizedText, '6064 29');
    return fcb && pitakard && account;
  }

  bool _isTextExist(RecognizedText recognized, String text) {
    for (TextBlock block in recognized.blocks) {
      for (TextLine line in block.lines) {
        if (line.text.contains(text)) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Future<void> close() async {
    state.emailController.dispose();
    state.firstNameController.dispose();
    state.lastNameController.dispose();
    state.mobileController.dispose();
    state.passwordController.dispose();
    state.confirmPasswordController.dispose();
    return super.close();
  }
  
  @override
  SignUpState? fromJson(Map<String, dynamic> json) {
    final isHydrated = json['hydrate'] as bool;
    return isHydrated
    ? state.copyWith(
        emailController: TextEditingController()..text = json['email'] as String,
        firstNameController: TextEditingController()..text = json['first_name'] as String,
        lastNameController: TextEditingController()..text = json['last_name'] as String,
        mobileController: TextEditingController()..text = json['mobile_number'] as String,
        passwordController: TextEditingController()..text = json['password'] as String,
        confirmPasswordController:TextEditingController()..text = json['confirm_password'] as String,
        //
        email: Email.dirty(json['email'] as String),
        firstName: Name.dirty(json['first_name'] as String),
        lastName:  Name.dirty(json['last_name'] as String),
        mobile: MobileNumber.dirty(json['mobile_number'] as String),
        password: Password.dirty(json['password'] as String),
        confirmPassword: ConfirmedPassword.dirty(password: json['password'] as String, value: json['confirm_password'] as String),
        hydratedStatus: isHydrated
      )
    : state.copyWith(hydratedStatus: false);
  }
  
  @override
  Map<String, dynamic>? toJson(SignUpState state) {
    return state.hydratedStatus
    ? {
        'email': state.email.value,
        'first_name': state.firstName.value,
        'last_name': state.lastName.value,
        'mobile_number': state.mobile.value,
        'password': state.password.value,
        'confirm_password': state.confirmPassword.value,
        'hydrate': state.hydratedStatus
      }
    : { 'hydrate': false };
  }
}
