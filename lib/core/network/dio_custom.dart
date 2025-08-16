import 'package:dio/dio.dart';

Dio buildDio({
  String baseUrl = "http://127.0.0.1:8000",
  Duration connectTimeout = const Duration(seconds: 10),
  Duration receiveTimeout = const Duration(seconds: 20),
}) {
  final dio = Dio(
    BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        baseUrl: baseUrl
        // Nếu dùng HTTPS tự ký cần cấu hình thêm (pinning/cert).
        // contentType mặc định application/json.
        ),
  );

  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: false,
    requestBody: false,
    responseHeader: false,
    responseBody: false, // bật true nếu muốn log body
    error: true,
  ));

  return dio;
}
