import 'package:dio/dio.dart';
import 'package:reetro_analyst_app/core/network/base_repository.dart';
import 'package:reetro_analyst_app/helper/either.dart';
import 'package:reetro_analyst_app/model/daily_stat.dart';
import 'package:reetro_analyst_app/model/partial_monthly_stat_model.dart';
import 'package:reetro_analyst_app/service_api/chart_service_api.dart';

class ChartRepository extends BaseRepository {
  late ChartApiService _chartApiService;

  ChartRepository(Dio dio) {
    _chartApiService = ChartApiService(dio);
  }

  Future<Either<List<DailyStat>, Exception>> getDailyStats(
      String start, String end) async {
    return safeCall(
        () => _chartApiService.getDailyStats(start: start, end: end));
  }

  Future<Either<PartialMonthlyStatModel, Exception>> getMonthlyStats(
      String today) async {
    return safeCall(() => _chartApiService.getMonthlyStats(today: today));
  }
}
