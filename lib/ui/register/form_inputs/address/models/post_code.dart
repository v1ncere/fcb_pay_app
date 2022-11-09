import 'package:formz/formz.dart';

enum PostCodeValidationError {
  required('Postcode can\'t be empty'),
  invalid('This postcode is invalid. Please try again.');

  const PostCodeValidationError(this.message);
  final String message;
}

class PostCode extends FormzInput<String, PostCodeValidationError> {
  const PostCode.pure() : super.pure('');
  const PostCode.dirty([super.value = '']) : super.dirty();

  static final RegExp _postalCodeRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');

  @override
  PostCodeValidationError? validator(String value) {
    return value.isEmpty
      ? PostCodeValidationError.required
      : _postalCodeRegExp.hasMatch(value)
        ? null
        : PostCodeValidationError.invalid;
  }
}