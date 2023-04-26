import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final List<String> letters = [
  'a', 'S', 'w', ')', 'q', 'D', '\$', 'f', ';', 'J', 'g', 'H', 'm', 'U', 'Z', 'o', 'l', 'P', 'c', 'R', 'B', 't', '5', '?',
  'v', 'E', 'k', 'X', 'N', 'y', '0', '!', '1', '%', '2', '*', 'A', '/', '9', '@', 'I', '6', '>', '7', 'K', '{', '4', ' ',
  '-', '"', '#', '(', ',', '.', '[', '\\', ']', '_', '`', '}', '~', '+', '<', '=', '\'', 'C', '3', 'n', ':', 'd', 's',
  'F', 'h', 'L', 'i', 'x', 'Q', 'r', '&', 'G', 'M', 'b', 'O', 'u', '|', 'z', 'T', 'e', '8', 'V', 'p', 'W', 'j', 'Y',
];

/// ENCRYPTING A STRING
String encryption(String data) {
  final List<String> date = ("${dayOfYear() + 2557}").split("");
  final List<String> input = data.split("");
  String encryptedKey = "";
  int keyIndex = 0;
  int counter = 0;

  for (var element in input) {
    counter = (counter < date.length) ? counter : 0;
    keyIndex = letters.indexWhere((index) => index.contains(element)) + int.parse(date[counter]);
    keyIndex = (letters.asMap().containsKey(keyIndex)) ? keyIndex : (letters.length - keyIndex).abs();
    encryptedKey += letters[keyIndex];
    counter++;
  }

  return encryptedKey;
}

/// DECRYPTING AN ENCRYPTED STRING
String decryption(String data) {
  final List<String> date = ("${dayOfYear() + 2557}").split("");
  final List<String> input = data.split("");
  String decryptedKey = "";
  int keyIndex = 0;
  int counter = 0;

  for (var element in input) {
    counter = (counter < date.length) ? counter : 0;
    keyIndex = letters.length + letters.indexWhere((index) => index.contains(element)) - int.parse(date[counter]);
    keyIndex = (letters.asMap().containsKey(keyIndex)) ? keyIndex : (letters.length - keyIndex).abs();
    decryptedKey += letters[keyIndex];
    counter++;
  }

  return decryptedKey;
}

/// TODAY IN DAYS
int dayOfYear() {
  final now = DateTime.now();
  final todayInDays = now.difference(DateTime(now.year, 1, 1, 0, 0)).inDays + 1;
  return todayInDays;
}

/// HASH SHA-1
String hashSha1(String input) {
  List<int> bytes = utf8.encode(input);
  Digest digest = sha1.convert(bytes);
  return digest.toString();
}

// THOUSANDS AND DECIMAL SEPARATOR
class ThousandsFormatter extends TextInputFormatter {
  ThousandsFormatter({
    this.allowFraction = false,
    this.decimalPlaces = 2,
    this.allowNegative = false,
  }) : _formatter = NumberFormat('#,##0.${'#' * decimalPlaces}');

  final bool allowFraction;
  final int decimalPlaces;
  final bool allowNegative;
  final NumberFormat _formatter;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String decimalSeparator = _formatter.symbols.DECIMAL_SEP;
    return textManipulation(
      oldValue,
      newValue,
      textInputFormatter: allowFraction
        ? (allowNegative 
            ? FilteringTextInputFormatter.allow(RegExp('[0-9-]+([$decimalSeparator])?'))
            : FilteringTextInputFormatter.allow(RegExp('[0-9]+([$decimalSeparator])?')))
        : (allowNegative
            ? FilteringTextInputFormatter.allow(RegExp('[0-9-]+'))
            : FilteringTextInputFormatter.digitsOnly),
      formatPattern: (String filteredString) {
        if (allowNegative) {
          if ('-'.allMatches(filteredString).isNotEmpty) {
            filteredString = (filteredString.startsWith('-') ? '-' : '') + filteredString.replaceAll('-', '');
          }
        }
        if (filteredString.isEmpty) return '';
        num number;
        if (allowFraction) {
          String decimalDigits = filteredString;
          if (decimalSeparator != '.') {
            decimalDigits = filteredString.replaceFirst(RegExp(decimalSeparator), '.');
          }
          number = double.tryParse(decimalDigits) ?? 0.0;
        } else {
          number = int.tryParse(filteredString) ?? 0;
        }
        final result = _formatter.format(number);
        if (allowFraction && filteredString.endsWith(decimalSeparator)) {
          return '$result$decimalSeparator';
        }
        if (allowNegative) {
          if (allowFraction) {
            if (filteredString == '-' || filteredString == '-0' || filteredString == '-0.') {
              return filteredString;
            }
          }
          if (filteredString == '-') {
            return filteredString;
          }
        }
        if (allowFraction && filteredString.contains('.')) {
          List<String> decimalPlacesValue = filteredString.split(".");
          String decimalOnly = decimalPlacesValue[1];
          String decimalTruncated = decimalOnly.substring(0, min(decimalPlaces, decimalOnly.length));
          double digitsOnly = double.tryParse(decimalPlacesValue[0]) ?? 0.0;
          String result = _formatter.format(digitsOnly);
          result = '$result.$decimalTruncated';
          return result;
        }
        return result;
      },
    );
  }
}

TextEditingValue textManipulation(TextEditingValue oldValue, TextEditingValue newValue, {
  TextInputFormatter? textInputFormatter, 
  String Function(String filteredString)? formatPattern,
}) {
  final originalUserInput = newValue.text;
  newValue = textInputFormatter != null 
    ? textInputFormatter.formatEditUpdate(oldValue, newValue)
    : newValue;
  
  int selectionIndex = newValue.selection.end;
  
  final newText = formatPattern != null 
    ? formatPattern(newValue.text) 
    : newValue.text;
  
  if (newText == newValue.text) {
    return newValue;
  }

  int insertCount = 0;
  int inputCount = 0;
  
  bool isUserInput(String s) {
    if (textInputFormatter == null) return originalUserInput.contains(s);
    
    return newValue.text.contains(s);
  }

  for (int i = 0; i < newText.length && inputCount < selectionIndex; i++) {
    final character = newText[i];

    if (isUserInput(character)) {
      inputCount++;
    } else {
      insertCount++;
    }
  }

  selectionIndex += insertCount;
  selectionIndex = min(selectionIndex, newText.length);

  if (selectionIndex - 1 >= 0 
  && selectionIndex - 1 < newText.length 
  && !isUserInput(newText[selectionIndex - 1])) {
    selectionIndex--;
  }

  return newValue.copyWith(
    text: newText,
    selection: TextSelection.collapsed(offset: selectionIndex),
    composing: TextRange.empty
  );
}

/// MATERIAL COLOR SELECTOR
MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};

  final int r = color.red;
  final int g = color.green;
  final int b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}