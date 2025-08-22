import 'package:dio/dio.dart';
import 'package:reetro_analyst_app/model/login/login_model.dart';
import 'package:reetro_analyst_app/model/login/login_request.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthAPI {
  factory AuthAPI(Dio dio) = _AuthAPI;

  @POST('/auth/login')
  Future<LoginModel> login(
    @Body() LoginRequest loginRequest,
  );
}
