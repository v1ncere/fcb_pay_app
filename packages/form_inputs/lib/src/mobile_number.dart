import 'package:formz/formz.dart';

enum MobileNumberValidationError { required, invalid }

class MobileNumber extends FormzInput<String, MobileNumberValidationError> {
  const MobileNumber.pure() : super.pure('');
  const MobileNumber.dirty([super.value = '']) : super.dirty();
  // static final _mobileRegExp = RegExp(r'(^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$)'); // [+63 (950) 416 8689]
  // static final _mobileRegExp = RegExp(r'^63\s\(\d{3}\)\s\d{3}\s\d{4}$'); // [63 (950) 416 8689]
  // static final _mobileRegExp = RegExp(r'^63\s\d{3}\s\d{3}\s\d{4}$'); // [63 950 416 8689]
  static final _mobileRegExp = RegExp(r'^9\d{9}$'); // 9504168689

  @override
  MobileNumberValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? MobileNumberValidationError.required
      : _mobileRegExp.hasMatch(value!)
        ? null
        : MobileNumberValidationError.invalid;
  }
}

extension MobileNumberValidationErrorX on MobileNumberValidationError {
  String text() {
    switch (this) {
      case MobileNumberValidationError.required:
        return 'Mobile number is required';
      case MobileNumberValidationError.invalid:
        return 'This mobile number is invalid. Please try again.';
    }
  }
}