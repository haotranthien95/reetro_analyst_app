import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  final String? accessToken;
  final String? tokenType;

  LoginModel({
    this.accessToken,
    this.tokenType,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
