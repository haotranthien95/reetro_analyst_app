import 'package:json_annotation/json_annotation.dart';
import 'package:reetro_analyst_app/model/login/login_model.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final LoginModel? data;

  LoginResponse({this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
