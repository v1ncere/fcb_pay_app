import 'package:formz/formz.dart';

enum MobileNumberValidationError {
  invalid
}

class MobileNumber extends FormzInput<String, MobileNumberValidationError> {

  const MobileNumber.pure() : super.pure('');
  const MobileNumber.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp = RegExp(r'^([+]\d{2}[ ])?\d{10}$');

  @override
  MobileNumberValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
      ? null
      : MobileNumberValidationError.invalid;
  }
}