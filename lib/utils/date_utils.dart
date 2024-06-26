// today in number of days
import 'dart:math';

import 'package:flutter/services.dart';

int dayOfYear() {
  final now = DateTime.now();
  final todayInDays = now.difference(DateTime(now.year, 1, 1, 0, 0)).inDays + 1;
  return todayInDays;
}

// convert DateTime into readable format [mmm dd, yyyy] and display if the date provided is today or yesterday
String getDynamicDateString(DateTime date) {
  DateTime now = DateTime.now();
  bool isToday = date.year == now.year // check if provided date is equals [now]
  && date.month == now.month
  && date.day == now.day;

  DateTime yesterday = now.subtract(const Duration(days: 1));
  bool isYesterday = date.year == yesterday.year // check if provided date is equals to [yesterday]
  && date.month == yesterday.month
  && date.day == yesterday.day;
  
  if(isToday) {
    return 'today';
  } else if(isYesterday) {
    return 'yesterday';
  } else {
    switch(date.month) {
      case 1:
        return 'Jan ${date.day}, ${date.year}';
      case 2:
        return 'Feb ${date.day}, ${date.year}';
      case 3:
        return 'Mar ${date.day}, ${date.year}';
      case 4:
        return 'Apr ${date.day}, ${date.year}';
      case 5:
        return 'May ${date.day}, ${date.year}';
      case 6:
        return 'Jun ${date.day}, ${date.year}';
      case 7:
        return 'Jul ${date.day}, ${date.year}';
      case 8:
        return 'Aug ${date.day}, ${date.year}';
      case 9:
        return 'Sep ${date.day}, ${date.year}';
      case 10:
        return 'Oct ${date.day}, ${date.year}';
      case 11:
        return 'Nov ${date.day}, ${date.year}';
      case 12:
        return 'Dec ${date.day}, ${date.year}';
      default:
        return '';
    }
  }
}

// convert DateTime into readable format [mmm dd, yyyy] only
String getDateString(DateTime date) {
  switch(date.month) {
    case 1:
      return 'Jan ${date.day}, ${date.year}';
    case 2:
      return 'Feb ${date.day}, ${date.year}';
    case 3:
      return 'Mar ${date.day}, ${date.year}';
    case 4:
      return 'Apr ${date.day}, ${date.year}';
    case 5:
      return 'May ${date.day}, ${date.year}';
    case 6:
      return 'Jun ${date.day}, ${date.year}';
    case 7:
      return 'Jul ${date.day}, ${date.year}';
    case 8:
      return 'Aug ${date.day}, ${date.year}';
    case 9:
      return 'Sep ${date.day}, ${date.year}';
    case 10:
      return 'Oct ${date.day}, ${date.year}';
    case 11:
      return 'Nov ${date.day}, ${date.year}';
    case 12:
      return 'Dec ${date.day}, ${date.year}';
    default:
      return '';
  }
}

String getDateStringfromMillis(int millis) {
  final date = millis <= 9999999999999
  ? DateTime.fromMillisecondsSinceEpoch(millis)
  : DateTime.now();
  
  switch(date.month) {
    case 1:
      return 'Jan ${date.day}, ${date.year}';
    case 2:
      return 'Feb ${date.day}, ${date.year}';
    case 3:
      return 'Mar ${date.day}, ${date.year}';
    case 4:
      return 'Apr ${date.day}, ${date.year}';
    case 5:
      return 'May ${date.day}, ${date.year}';
    case 6:
      return 'Jun ${date.day}, ${date.year}';
    case 7:
      return 'Jul ${date.day}, ${date.year}';
    case 8:
      return 'Aug ${date.day}, ${date.year}';
    case 9:
      return 'Sep ${date.day}, ${date.year}';
    case 10:
      return 'Oct ${date.day}, ${date.year}';
    case 11:
      return 'Nov ${date.day}, ${date.year}';
    case 12:
      return 'Dec ${date.day}, ${date.year}';
    default:
      return '';
  }
}

final List<String> monthName = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

class CustomDateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '/', oldValue);
    return newValue.copyWith(
        text: text, selection: _updateCursorPosition(text, oldValue));
  }
}

String _format(String value, String seperator, TextEditingValue old) {
  var finalString = '';
  var dd = '';
  var mm = '';
  var yyy = '';
  var oldVal = old.text;
  var tempOldval = oldVal;
  var tempValue = value;
  if (!oldVal.contains(seperator) ||
      oldVal.isEmpty ||
      seperator.allMatches(oldVal).length < 2) {
    oldVal += '///';
  }
  if (!value.contains(seperator) || _backSlashCount(value) < 2) {
    value += '///';
  }
  var splitArrOLD = oldVal.split(seperator);
  var splitArrNEW = value.split(seperator);
  for (var i = 0; i < 3; i++) {
    splitArrOLD[i] = splitArrOLD[i].toString().trim();
    splitArrNEW[i] = splitArrNEW[i].toString().trim();
  }
  // block erasing
  if ((splitArrOLD[0].isNotEmpty &&
      splitArrOLD[2].isNotEmpty &&
      splitArrOLD[1].isEmpty &&
      tempValue.length < tempOldval.length &&
      splitArrOLD[0] == splitArrNEW[0] &&
      splitArrOLD[2].toString().trim() ==
          splitArrNEW[1].toString().trim()) ||
      (_backSlashCount(tempOldval) > _backSlashCount(tempValue) &&
          splitArrNEW[1].length > 2) ||
      (splitArrNEW[0].length > 2 && _backSlashCount(tempOldval) == 1) ||
      (_backSlashCount(tempOldval) == 2 &&
          _backSlashCount(tempValue) == 1 &&
          splitArrNEW[0].length > splitArrOLD[0].length)) {
    finalString = tempOldval; // making the old date as it is
  } else {
    if (splitArrNEW[0].length > splitArrOLD[0].length) {
      if (splitArrNEW[0].length < 3) {
        dd = splitArrNEW[0];
      } else {
        for (var i = 0; i < 2; i++) {
          dd += splitArrNEW[0][i];
        }
      }
      if (dd.length == 2 && !dd.contains(seperator)) {
        dd += seperator;
      }
    } else if (splitArrNEW[0].length == splitArrOLD[0].length) {
      if (oldVal.length > value.length && splitArrNEW[1].isEmpty) {
        dd = splitArrNEW[0];
      } else {
        dd = splitArrNEW[0] + seperator;
      }
    } else if (splitArrNEW[0].length < splitArrOLD[0].length) {
      if (oldVal.length > value.length &&
          splitArrNEW[1].isEmpty &&
          splitArrNEW[0].isNotEmpty) {
        dd = splitArrNEW[0];
      } else if (tempOldval.length > tempValue.length &&
          splitArrNEW[0].isEmpty &&
          _backSlashCount(tempValue) == 2) {
        dd += seperator;
      } else {
        if (splitArrNEW[0].isNotEmpty) {
          dd = splitArrNEW[0] + seperator;
        }
      }
    }

    if (dd.isNotEmpty) {
      finalString = dd;
      if (dd.length == 2 &&
          !dd.contains(seperator) &&
          oldVal.length < value.length &&
          splitArrNEW[1].isNotEmpty) {
        if (seperator.allMatches(dd).isEmpty) {
          finalString += seperator;
        }
      } else if (splitArrNEW[2].isNotEmpty &&
          splitArrNEW[1].isEmpty &&
          tempOldval.length > tempValue.length) {
        if (seperator.allMatches(dd).isEmpty) {
          finalString += seperator;
        }
      } else if (oldVal.length < value.length &&
          (splitArrNEW[1].isNotEmpty || splitArrNEW[2].isNotEmpty)) {
        if (seperator.allMatches(dd).isEmpty) {
          finalString += seperator;
        }
      }
    } else if (_backSlashCount(tempOldval) == 2 && splitArrNEW[1].isNotEmpty) {
      dd += seperator;
    }
    if (splitArrNEW[0].length == 3 && splitArrOLD[1].isEmpty) {
      mm = splitArrNEW[0][2];
    }

    if (splitArrNEW[1].length > splitArrOLD[1].length) {
      if (splitArrNEW[1].length < 3) {
        mm = splitArrNEW[1];
      } else {
        for (var i = 0; i < 2; i++) {
          mm += splitArrNEW[1][i];
        }
      }
      if (mm.length == 2 && !mm.contains(seperator)) {
        mm += seperator;
      }
    } else if (splitArrNEW[1].length == splitArrOLD[1].length) {
      if (splitArrNEW[1].isNotEmpty) {
        mm = splitArrNEW[1];
      }
    } else if (splitArrNEW[1].length < splitArrOLD[1].length) {
      if (splitArrNEW[1].isNotEmpty) {
        mm = splitArrNEW[1] + seperator;
      }
    }

    if (mm.isNotEmpty) {
      finalString += mm;
      if (mm.length == 2 && !mm.contains(seperator)) {
        if (tempOldval.length < tempValue.length) {
          finalString += seperator;
        }
      }
    }
    if (splitArrNEW[1].length == 3 && splitArrOLD[2].isEmpty) {
      yyy = splitArrNEW[1][2];
    }

    if (splitArrNEW[2].length > splitArrOLD[2].length) {
      if (splitArrNEW[2].length < 5) {
        yyy = splitArrNEW[2];
      } else {
        for (var i = 0; i < 4; i++) {
          yyy += splitArrNEW[2][i];
        }
      }
    } else if (splitArrNEW[2].length == splitArrOLD[2].length) {
      if (splitArrNEW[2].isNotEmpty) {
        yyy = splitArrNEW[2];
      }
    } else if (splitArrNEW[2].length < splitArrOLD[2].length) {
      yyy = splitArrNEW[2];
    }

    if (yyy.isNotEmpty) {
      if (_backSlashCount(finalString) < 2) {
        if (splitArrNEW[0].isEmpty && splitArrNEW[1].isEmpty) {
          finalString = seperator + seperator + yyy;
        } else {
          finalString = finalString + seperator + yyy;
        }
      } else {
        finalString += yyy;
      }
    } else {
      if (_backSlashCount(finalString) > 1 && oldVal.length > value.length) {
        var valueUpdate = finalString.split(seperator);
        finalString = valueUpdate[0] + seperator + valueUpdate[1];
      }
    }

  }
  
  return finalString;
}

TextSelection _updateCursorPosition(String text, TextEditingValue oldValue) {
  var endOffset = max(
    oldValue.text.length - oldValue.selection.end,
    0,
  );
  var selectionEnd = text.length - endOffset;
  return TextSelection.fromPosition(TextPosition(offset: selectionEnd));
}

int _backSlashCount(String value) {
  return '/'.allMatches(value).length;
}