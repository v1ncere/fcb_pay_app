import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'utils.dart';

/// SHA-1
String hashSha1(String data) {
  List<int> bytes = utf8.encode(data);
  Digest digest = sha1.convert(bytes);
  return digest.toString();
}

final List<String> letters = [
  'a', 'S', 'w', ')', 'q', 'D', '\$', 'f', ';', 'J', 'g', 'H', 'm', 'U', 'Z', 'o', 'l', 'P', 'c', 'R', 'B', 't', '5', '?',
  'v', 'E', 'k', 'X', 'N', 'y', '0', '!', '1', '%', '2', '*', 'A', '/', '9', '@', 'I', '6', '>', '7', 'K', '{', '4', ' ',
  '-', '"', '#', '(', ',', '.', '[', '\\', ']', '_', '`', '}', '~', '+', '<', '=', '\'', 'C', '3', 'n', ':', 'd', 's',
  'F', 'h', 'L', 'i', 'x', 'Q', 'r', '&', 'G', 'M', 'b', 'O', 'u', '|', 'z', 'T', 'e', '8', 'V', 'p', 'W', 'j', 'Y',
];

/// ENCRYPT
String encryption(String data) {
  final List<String> date = ('${dayOfYear() + 2557}').split('');
  final List<String> splitData = data.split('');
  String encryptedData = '';
  int index = 0;
  int counter = 0;

  for (var element in splitData) {
    counter = (counter < date.length) ? counter : 0;
    index = letters.indexWhere((index) => index.contains(element)) + int.parse(date[counter]);
    index = (letters.asMap().containsKey(index)) ? index  : (letters.length - index).abs();
    encryptedData += letters[index];
    counter++;
  }

  return encryptedData;
}

/// DECRYPT
String decryption(String data) {
  final List<String> date = ('${dayOfYear() + 2557}').split('');
  final List<String> splitData = data.split('');
  String decryptedData = '';
  int index = 0;
  int counter = 0;

  for (var element in splitData) {
    counter = (counter < date.length) ? counter  : 0;
    index = letters.length + letters.indexWhere((index) => index.contains(element)) - int.parse(date[counter]);
    index = (letters.asMap().containsKey(index)) ? index : (letters.length - index).abs();
    decryptedData += letters[index];
    counter++;
  }

  return decryptedData;
}