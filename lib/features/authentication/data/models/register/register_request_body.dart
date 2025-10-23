import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/api/api_constant/api_constant.dart';

part 'register_request_body.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  @JsonKey(name: ApiConstants.email)
  final String email;
  @JsonKey(name: ApiConstants.password)
  final String password;
  @JsonKey(name: ApiConstants.firstName)
  final String firstName;
  @JsonKey(name: ApiConstants.lastName)
  final String lastName;
  @JsonKey(name: ApiConstants.phoneNumber)
  final String phoneNumber;
  @JsonKey(name: ApiConstants.accountType)
  final int accountType;
  @JsonKey(name: ApiConstants.loginProvider)
  final String loginProvider;

  RegisterRequestBody({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.accountType,
    required this.loginProvider,
  });
  factory RegisterRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);
}
