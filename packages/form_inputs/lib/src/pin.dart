import 'package:formz/formz.dart';

enum PinValidationError { required, invalid }

class Pin extends FormzInput<String, PinValidationError> {
  const Pin.pure() : super.pure('');
  const Pin.dirty([super.value = '']) : super.dirty();
  
  static final _numbersRegex = RegExp(r'^\d+$'); // match to only number

  @override
  PinValidationError? validator(String? value) {
    return value?.isEmpty == true
    ? PinValidationError.required
    : _numbersRegex.hasMatch(value!)
      ? null
      : PinValidationError.invalid;
  }
}

extension PinValidationErrorX on PinValidationError {
  String text() {
    switch (this) {
      case PinValidationError.required:
        return 'Pin is required.';
      case PinValidationError.invalid:
        return 'Pin is invalid. Please try again.';
    }
  }
}