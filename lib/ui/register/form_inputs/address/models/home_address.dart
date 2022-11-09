import 'package:formz/formz.dart';

enum HomeAddressValidationError {
  required('Email can\'t be empty'),
  invalid('This address is invalid. Please try again.');

  const HomeAddressValidationError(this.message);
  final String message;
}

class HomeAddress extends FormzInput<String, HomeAddressValidationError> {
  const HomeAddress.pure() : super.pure('');
  const HomeAddress.dirty([super.value = '']) : super.dirty();

  static final RegExp _addressRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');

  @override
  HomeAddressValidationError? validator(String value) {
    return value.isEmpty
      ? HomeAddressValidationError.required
      : _addressRegExp.hasMatch(value)
        ? null
        : HomeAddressValidationError.invalid;
  }
}