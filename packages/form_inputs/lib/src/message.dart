import 'package:formz/formz.dart';

enum MessageValidationError { exceed }

class Message extends FormzInput<String, MessageValidationError> {
  const Message.pure() : super.pure('');
  const Message.dirty([super.value = '']) : super.dirty();
  
  @override
  MessageValidationError? validator(String? value) {
    return value!.length > 500
      ? MessageValidationError.exceed
      : null;
  }
}

extension MessageValidationErrorX on MessageValidationError {
  String text() {
    switch (this) {
      case MessageValidationError.exceed:
        return 'Exceeded character limit. Please limit your input to 500 characters or less.';
    }
  }
}