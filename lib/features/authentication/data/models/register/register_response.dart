import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/features/authentication/domain/entites/register/register_entity.dart';

import '../../../../../core/api/api_constant/api_constant.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: ApiConstants.fullName)
  final String? fullName;
  @JsonKey(name: ApiConstants.email)
  final String? email;
  @JsonKey(name: ApiConstants.phoneNumber)
  final String? phoneNumber;
  @JsonKey(name: ApiConstants.roles)
  final List<String>? roles;
  @JsonKey(name: ApiConstants.loginProvider)
  final String? loginProvider;
  @JsonKey(name: ApiConstants.token)
  final String? token;
  @JsonKey(name: ApiConstants.refreshTokenExpiration)
  final String? refreshTokenExpiration;

  const RegisterResponse({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.roles,
    this.loginProvider,
    this.token,
    this.refreshTokenExpiration,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  RegisterEntity toEntity() {
    return RegisterEntity(
        token: token, refreshToken: refreshTokenExpiration, fullName: fullName);
  }
}
