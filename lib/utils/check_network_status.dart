import 'package:dio/dio.dart';

// check if there are internet connectivity
Future<bool> checkNetworkStatus() async {
  try {
    final dio = Dio();
    final response = await dio.get('https://example.com');
    return response.statusCode == 200 ? true : false;
  } catch (_) {
    return false;
  }
}
