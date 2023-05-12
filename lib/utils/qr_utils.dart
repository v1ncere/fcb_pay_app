import 'dart:convert';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

String crc16CCITT(String data) {
  Uint8List bytes = Uint8List.fromList(utf8.encode(data)); // data converted into list of 8-bit unsigned integers
  int crc = 0xFFFF; // initial value
  int polynomial = 0x1021; // 0001 0000 0010 0001 (0, 5, 12)

  for (var b in bytes) {
    for (int i = 0; i < 8; i++) {
      bool bit = ((b >> (7-i) & 1) == 1);
      bool c15 = ((crc >> 15 & 1) == 1);
      crc <<= 1;
      if (c15 ^ bit) crc ^= polynomial;
    }
  }
  
  return (crc &= 0xffff).toRadixString(16).toUpperCase();
}

// QR data parser
List<String> qrDataParser(String code) {
  List<String> list = [];

  for(int i = 0; i < code.length; ) {
    String id = code.substring(i, i + 2);
    String length = code.substring(i + 2, i + 4);
    String data = code.substring(i + 4, i + 4 + int.parse(length));

    if ((int.parse(id) >= 02 && int.parse(id) <= 51)
    || (int.parse(id) == 62)
    || (int.parse(id) == 64)
    || (int.parse(id) >= 80 && int.parse(id) <= 99)) {
      
      for (int x = 0; x < data.length; ) {
        String innerId = data.substring(x, x + 2);
        String innerLength = data.substring(x + 2, x + 4);
        String innerData = data.substring(x + 4, x + 4 + int.parse(innerLength));
        list.add('sub$id$innerId$innerLength$innerData');
        x = x + 4 + (int.parse(innerLength));
      }
    } else {
      list.add('main$id$length$data');
    }
    i = i + 4 + (int.parse(length));
  }
  return list;
}

class CodeModel extends Equatable {
  final String? id;
  final String? length;
  final String? data;
  final String? parentId;

  const CodeModel({
    this.id = "",
    this.length = "",
    this.data = "",
    this.parentId = "",
  });

  CodeModel copyWith({
    String? id,
    String? length,
    String? data,
    String? parentId,
  }) {
    return CodeModel(
      id: id ?? this.id,
      length: length ?? this.length,
      data: data ?? this.data,
      parentId: parentId ?? this.parentId,
    );
  }
  
  @override
  List<Object?> get props => [id, length, data, parentId];
}