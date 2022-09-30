class FirstPageRepository {
  late String _data;

  Future<void> fetchData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    _data = 'First Page';
  }

  String get data => _data;
}