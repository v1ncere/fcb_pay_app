import 'package:formz/formz.dart';

enum MobileNumberValidationError {
  required('Mobile number can\'t be empty.'),
  invalid('This mobile number is invalid. Please try again.');

  const MobileNumberValidationError(this.message);
  final String message;
}

class MobileNumber extends FormzInput<String, MobileNumberValidationError> {
  const MobileNumber.pure() : super.pure('');
  const MobileNumber.dirty([super.value = '']) : super.dirty();
  static final _mobileRegExp = RegExp(r'(^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$)');

  @override
  MobileNumberValidationError? validator(String value) {
    return value.isEmpty
      ? MobileNumberValidationError.required
      : _mobileRegExp.hasMatch(value)
        ? null
        : MobileNumberValidationError.invalid;
  }
}