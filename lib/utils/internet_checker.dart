import 'package:dio/dio.dart';

Future<bool> internetChecker() async {
  try {
    final dio = Dio();
    final response = await dio.get('https://example.com');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
