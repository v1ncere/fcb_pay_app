import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:hive_repository/hive_repository.dart';

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

// Scanned QRC into List<QRModel>
List<QRModel> qrDataParser(String qr) {
  List<QRModel> list = [];

  for(int x = 0; x < qr.length; ) {
    String id = qr.substring(x, x + 2);
    String length = qr.substring(x + 2, x + 4);
    String data = qr.substring(x + 4, x + 4 + int.parse(length));
    int ids = int.parse(id);

    if ((ids >= 02 && ids <= 51) || (ids == 62) || (ids == 64) || (ids >= 80 && ids <= 99)) {
      for (int i = 0; i < data.length; ) {
        String iId = data.substring(i, i + 2);
        String iLength = data.substring(i + 2, i + 4);
        String iData = data.substring(i + 4, i + 4 + int.parse(iLength));
        
        // add data with the sub id to List<QRModel>
        list.add(QRModel(
          id: 'subs$id$iId',
          data: iData,
          title: qrDataTitleWidget('subs$id$iId', 'title'),
          widget: qrDataTitleWidget('subs$id$iId', 'widget'),
        ));
        i = i + 4 + (int.parse(iLength));
      }
    } else {
      // add data with the main id to List<QRModel>
      list.add(QRModel(
        id: 'main$id',
        data: data,
        title: qrDataTitleWidget('main$id$data', 'title'),
        widget: qrDataTitleWidget('main$id', 'widget'),
      ));
    }
    x = x + 4 + (int.parse(length));
  }
  return list;
}

// // Scanned QRC into List<String>
// List<String> qrDataParser(String qr) {
//   List<String> list = [];

//   for(int x = 0; x < qr.length; ) {
//     String id = qr.substring(x, x + 2);
//     String length = qr.substring(x + 2, x + 4);
//     String data = qr.substring(x + 4, x + 4 + int.parse(length));
//     int ids = int.parse(id);

//     if ((ids >= 02 && ids <= 51) || (ids == 62) || (ids == 64) || (ids >= 80 && ids <= 99)) {
      
//       for (int y = 0; y < data.length; ) {
//         String iId = data.substring(y, y + 2);
//         String iLength = data.substring(y + 2, y + 4);
//         String iData = data.substring(y + 4, y + 4 + int.parse(iLength));
//         list.add('subs$id$iId$iLength$iData');
//         y = y + 4 + (int.parse(iLength));
//       }

//       list.add('main$id');
//     } else {
//       list.add('main$id$length$data');
//     }

//     x = x + 4 + (int.parse(length));
//   }
//   return list;
// }

String qrDataTitleWidget(String data, String req) {
  // if 'title' 'widget'
  final ids = data.trim().substring(0, 4);
  if(ids.contains('main')) {
    final id = int.parse(data.trim().substring(4, 6));
    switch(id) {
      case 00:
        return req == 'title' ? 'Version' : 'text'; // Payload Format Indicator
      case 01: // Point of Initiation Method
        if(req == 'title') {
          final res = int.parse(data.trim().substring(6, 8));
          if (res == 11) {
            return 'Static QR Code';
          } else if (res == 12) {
            return 'Dynamic Qr Code';
          } else {
            return '';
          }
        } else if (req == 'widget') {
          return req = 'text'; 
        } else {
          return '';
        }
      case >= 02 && <= 51:
        return req == 'title' ? 'Merchant Account Information' : 'text';
      case 52:
        return req == 'title' ? 'Merchant Category Code' : 'text';
      case 53:
        return req == 'title' ? 'Transaction Currency Code' : 'text';
      case 54:
        return req == 'title' ? 'Transaction Amount' : 'text';
      case 55:
        return req == 'title' ? 'Tip or Convenience Indicator' : 'text';
      case 56:
        return req == 'title' ? 'Value of Convenience Fee Fixed' : 'text';
      case 57:
        return req == 'title' ? 'Value of Convenience Fee Percentage' : 'text';
      case 58:
        return req == 'title' ? 'Country Code' : 'text';
      case 59:
        return req == 'title' ? 'Merchant Name' : 'text';
      case 60:
        return req == 'title' ? 'Merchant City' : 'text';
      case 61:
        return req == 'title' ? 'Postal Code' : 'text';
      case 62:
        return req == 'title' ? 'Additional Data Field' : 'text';
      case 63:
        return req == 'title' ? 'Cyclic Redunduncy Check(CRC)' : 'text';
      case 64:
        return req == 'title' ? 'Merchant Information' : 'text'; // Language Template
      case >= 65 && <= 79:
        return req == 'title' ? 'RFU for EMVCo' : 'text';
      case >= 80 && <= 99:
        return req == 'title' ? 'Unreserved Templates' : 'text';
      case 88:
        return req == 'title' ? 'Merchant Settlement & Auth Details' : 'text';
      default:
        return '';
    }
  } else if (ids.contains('subs')) {
    final idInString = data.trim().substring(4, 8);
    final subId = int.parse(idInString.substring(2, 4));
    switch (int.parse(idInString)) {
      case (>= 0200 && <= 5199) &&
        != 2800 && != 2801 &&
        != 2803 && != 2804 &&
        != 2805:
        if (subId == 00) {
          return req == 'title' ? 'Globally Unique Identifier' : 'text';
        } else if (subId >= 01 && subId <= 99) {
          return req == 'title' ? 'Payment Network Specific'  : 'text';
        } else {
          return '';
        }
      case 2800:
        return req == 'title' ? 'Payment System Unique ID' : 'text';
      case 2801:
        return req == 'title' ? 'Acquirer ID' : 'text';
      case 2803:
        return req == 'title' ? 'Merchant ID' : 'text';
      case 2804:
        return req == 'title' ? 'Merchant Credit Account' : 'text';
      case 2805:
        return req == 'title' ? 'Proxy-Notify Flags' : 'text';
      case 6201:
        return req == 'title' ? 'Bill Number' : 'text';
      case 6202:
        return req == 'title' ? 'Mobile Number' : 'textfield';
      case 6203:
        return req == 'title' ? 'Store Label' : 'text';
      case 6204:
        return req == 'title' ? 'Loyalty Number' : 'text';
      case 6205:
        return req == 'title' ? 'Reference Label' : 'text'; // 
      case 6206:
        return req == 'title' ? 'Customer Label' : 'text';
      case 6207:
        return req == 'title' ? 'Terminal Label' : 'text';
      case 6208:
        return req == 'title' ? 'Purpose of Transaction' : 'text';
      case 6209:
        return req == 'title' ? 'Additional Consumer Data Request' : 'text';
      case >= 6210 && <= 6249:
        return req == 'title' ? 'RFU for EMVCo' : 'text';
      case >= 6250 && <= 6299:
        return req == 'title' ? 'Payment System Specific' : 'text';
      case 6400:
        return req == 'title' ? 'Language Preference' : 'text';
      case 6401:
        return req == 'title' ? 'Merchant Name' : 'text';
      case 6402:
        return req == 'title' ? 'Merchant City' : 'text';
      case >= 6403 && <= 6499:
        return req == 'title' ? 'RFU FOR EMVCo' : 'text';
      case (>= 8000 && <= 9999) &&
        != 8800 && != 8801:
        if (subId == 00) {
          return req == 'title' ? 'Globally Unique Identifier' : 'text';
        } else if (subId >= 01 && subId <= 99) {
          return req == 'title' ? 'Context Specific Data' : 'text';
        } else {
          return '';
        }
      case 8800:
        return req == 'title' ? 'Payment System Unique ID' : 'text';
      case 8801:
        return req == 'title' ? 'Aquirer-Required Information' : 'text';
      default:
        return '';
    }
  } else {
    return '';
  }
}

// List<String> qrProxyNotifyFlags(String data) {
//   List<String> list = [];
//   switch(data.trim().substring(0, 1)) {
//     case '0':
//       list.add('Actual Account Number');
//       break;
//     case '1':
//       list.add('Mobile Number');
//       break;
//     case '2':
//       list.add('Token ID');
//       break;
//     case '3':
//       list.add('Alias Name/Nickname in Merchant Credit Account or the Merchant ID');
//       break;
//     case '4':
//       list.add('Masked Account Detail');
//       break;
//     case '5':
//       list.add('National ID');
//       break;
//     case 'Z':
//       list.add('Others');
//       break;
//     default:
//       return list;
//   }
//   switch(data.trim().substring(1, 2)) {
//     case '0':
//       list.add('No notification needed');
//       break;
//     case '1':
//       list.add('Notification required');
//       break;
//     default:
//       return list;
//   }
//     switch(data.trim().substring(2, 3)) {
//     case '0':
//       list.add('Amount not editable; Amount not present in QR');
//       break;
//     case '1':
//       list.add('Amount editable, any amount');
//       break;
//     case '2':
//       list.add('Amount editable, amount not more than xxx limit');
//       break;
//     default:
//       return list;
//   }
//   return list;
// }

class QRCodeFailure implements Exception {
  const QRCodeFailure([
    this.message = 'An unknown exception occurred.'
  ]);
  factory QRCodeFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-mai':
        return const QRCodeFailure(
          'The P2M template ID “28” must never be used together with the P2P ID “27” in one QR code.'
        );
      case 'no-merchant-id':
        return const QRCodeFailure(
          'Merchant ID and Merchant Credit Account is empty. Authentication failed.'
        );
      case 'crc-not-match':
        return const QRCodeFailure(
          'Invalid QR code. Please ensure that the QR code is not damaged and that it belongs to this service.'
        );
      case 'qr-empty':
        return const QRCodeFailure(
          'Empty QR code data. Please ensure that the QR code contains valid information and try again.'
        );
      default:
        return const QRCodeFailure();
    }
  }
  final String message;
}