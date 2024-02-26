import 'package:dio/dio.dart';
import 'package:event_booking/utils/url.dart';

class HttpServices {
  static final HttpServices _instance = HttpServices.internal();
  factory HttpServices() => _instance;
  HttpServices.internal();

  Dio? _dio;
  Dio getDioInstance() {
    if (_dio == null) {
      return _dio = Dio(
        BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(milliseconds: 10000)),
      );
    } else {
      return _dio!;
    }
  }
}
