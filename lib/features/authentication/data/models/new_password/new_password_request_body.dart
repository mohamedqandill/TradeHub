import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/api/api_constant/api_constant.dart';

part 'new_password_request_body.g.dart';

@JsonSerializable()
class NewPasswordRequestBody {
  @JsonKey(name: ApiConstants.emailCap)
  final String? Email;
  @JsonKey(name: ApiConstants.otpCode)
  final String? otpCode;
  @JsonKey(name: ApiConstants.newPassword)
  final String? NewPassword;

  const NewPasswordRequestBody({
    this.Email,
    this.otpCode,
    this.NewPassword,
  });

  factory NewPasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$NewPasswordRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$NewPasswordRequestBodyToJson(this);
}
