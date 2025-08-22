import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reetro_analyst_app/helper/either.dart';

class BaseRepository {
  Future<Either<T, Exception>> safeCall<T>(
      Future<T> Function() tryFetch) async {
    try {
      final result = await tryFetch();
      return Left(result);
    } on DioException catch (e, stacktrace) {
      // ignore: avoid_print
      print('DioErrorException: $e');
      // ignore: avoid_print
      print('DioErrorStacktrace: $stacktrace');
      // if (e.response?.data != null) {
      //   try {
      //     final response = BadResponseModel.fromJson(e.response?.data);
      //     return Right(Exception(response.detail ?? response.message));
      //   } catch (error) {
      //     return Right(Exception(e.response?.data));
      //   }
      // }
      if ((e.message ?? '').contains('SocketException')) {
        return Right(Exception('Disconnect from internet! Please Try again!'));
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        return Right(Exception('Receive timeout! Please Try again!'));
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        return Right(Exception('Connection timeout! Please Try again!'));
      }
      if (e.type == DioExceptionType.sendTimeout) {
        return Right(Exception('Send timeout! Please Try again!'));
      }
      return Right(e);
    } catch (e, stacktrace) {
      // ignore: avoid_print
      print('Exception: $e');
      // ignore: avoid_print
      print('Stacktrace: $stacktrace');
      if (e is SocketException) {
        return Right(Exception('Disconnect from internet! Please Try again!'));
      }
      return Right(Exception(e.toString()));
    }
  }
}
