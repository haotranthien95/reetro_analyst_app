import 'package:reetro_analyst_app/core/network/dio_custom.dart';
import 'package:reetro_analyst_app/service_api/chart_service_api.dart';

final di = DI();

class DI {
  DI._privateConstructor();

  static final DI _instance = DI._privateConstructor();

  factory DI() {
    return _instance;
  }

  final ChartApiService chartApiService = ChartApiService(buildDio());
}
