// milliseconds converter
DateTime? millisConverter(int? date) {
  return date != null && date <= 9999999999999 
  ? DateTime.fromMillisecondsSinceEpoch(date) 
  : null;
}

// int to double converter
double? doubleConverter(dynamic amount) {
  return amount is int ? amount.toDouble() : amount as double?;
}