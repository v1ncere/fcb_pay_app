import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  PhoneNumberFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    
    // for original with +
    // if (!oldValue.text.contains('(') && oldValue.text.length >= 10 && newValue.text.length != oldValue.text.length) {
    //   return const TextEditingValue(
    //     text: '',
    //     selection: TextSelection.collapsed(offset: 0),
    //   );
    // }

    if (oldValue.text.length > newValue.text.length) {
      return TextEditingValue(
        text: newValue.text.toString(),
        selection: TextSelection.collapsed(offset: newValue.text.length),
      );
    }

    // for original with +
    // var newText = newValue.text;
    // if (newText.length == 3) newText = '$newText (';
    // if (newText.length == 8) newText = '$newText) ';
    // if (newText.length == 13) newText = '$newText ';

    var newText = newValue.text;
    if (newText.length == 2) newText = '$newText ';
    if (newText.length == 6) newText = '$newText ';
    if (newText.length == 10) newText = '$newText ';

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}