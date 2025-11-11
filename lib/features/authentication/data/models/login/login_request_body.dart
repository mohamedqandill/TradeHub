import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/api/api_constant/api_constant.dart';

part 'login_request_body.g.dart';

@JsonSerializable()
class LoginRequestBody {
  @JsonKey(name: ApiConstants.emailCap)
  final String? email;
  @JsonKey(name: ApiConstants.password)
  final String? password;

  const LoginRequestBody({
    this.email,
    this.password,
  });

  factory LoginRequestBody.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);
}
