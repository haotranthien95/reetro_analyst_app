import 'package:dio/dio.dart';
import 'package:reetro_analyst_app/model/daily_stat.dart';
import 'package:reetro_analyst_app/model/partial_monthly_stat_model.dart';
import 'package:retrofit/retrofit.dart';
part 'chart_service_api.g.dart';

@RestApi()
abstract class ChartApiService {
  factory ChartApiService(Dio dio, {String baseUrl}) = _ChartApiService;

  /// GET /api/stats/daily?start=YYYY-MM-DD&end=YYYY-MM-DD
  @GET("/api/stats/daily")
  Future<List<DailyStat>> getDailyStats({
    /// start (YYYY-MM-DD)
    @Query("start") required String start,

    /// end (YYYY-MM-DD)
    @Query("end") required String end,
  });

  @GET("/api/stats/partial-monthly")
  Future<PartialMonthlyStatModel> getMonthlyStats({
    /// today (YYYY-MM-DD)
    @Query("today") required String today,
  });
}
