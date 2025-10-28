import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/api/api_constant/api_constant.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDTO {
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

  const LoginResponseDTO({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.roles,
    this.loginProvider,
    this.token,
    this.refreshTokenExpiration,
  });

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDTOToJson(this);
}
