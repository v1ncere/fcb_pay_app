import 'dart:math';

class SecondPageRepository {
  late int _data;

  Future<void> fetchData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    _data = Random().nextInt(1000);
  }

  int get data => _data;
}