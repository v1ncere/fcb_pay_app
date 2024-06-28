String maskedNum(String data) {
  final subs = data.substring(data.length - 4);
  return '**** **** **** $subs';
}