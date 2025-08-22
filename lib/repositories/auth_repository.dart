import 'package:dio/dio.dart';
import 'package:reetro_analyst_app/core/network/base_repository.dart';
import 'package:reetro_analyst_app/helper/either.dart';
import 'package:reetro_analyst_app/model/login/login_model.dart';
import 'package:reetro_analyst_app/model/login/login_request.dart';
import 'package:reetro_analyst_app/service_api/auth/auth_api_service.dart';

class AuthRepository extends BaseRepository {
  late AuthAPI _authAPI;

  AuthRepository(Dio dio) {
    _authAPI = AuthAPI(dio);
  }

  Future<Either<LoginModel, Exception>> login(
      String username, String password) async {
    return safeCall(() =>
        _authAPI.login(LoginRequest(username: username, password: password)));
  }
}
