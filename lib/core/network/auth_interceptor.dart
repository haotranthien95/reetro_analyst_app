import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reetro_analyst_app/core/local/shared_ref.dart';
import 'package:reetro_analyst_app/main.dart';
import 'package:reetro_analyst_app/presentation/login/login_screen.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  AuthInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!isAuthenticationAlready(options)) {
      var accessToken = prefs.getString('access_token');
      if ((accessToken ?? '').isNotEmpty) {
        // ignore: avoid_print

        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // var myNavkey = locator.get<NavigationService>().navigatorKey;

    if (err.response != null && err.response?.statusCode == 403) {
      prefs.setString("access_token", "");
      Navigator.of(navigatorKey.currentContext!).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      handler.next(err);
    }
  }

  bool isAuthenticationAlready(RequestOptions options) {
    return options.headers.containsKey('Authorization');
  }
}
