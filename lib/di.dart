import 'package:reetro_analyst_app/core/network/dio_custom.dart';
import 'package:reetro_analyst_app/repositories/auth_repository.dart';
import 'package:reetro_analyst_app/repositories/chart_repository.dart';

import 'package:get_it/get_it.dart';

GetIt di = GetIt.instance;

Future<void> initDependency() async {
  final dio = buildDio();

  di.registerLazySingleton<AuthRepository>(() => AuthRepository(dio));
  di.registerLazySingleton<ChartRepository>(() => ChartRepository(dio));
}
