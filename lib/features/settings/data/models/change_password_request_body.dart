import 'package:json_annotation/json_annotation.dart';

part 'change_password_request_body.g.dart';

@JsonSerializable()
class ChangePasswordRequestBody {
  @JsonKey(name: "CurrentPassword")
  final String currentPassword;
  @JsonKey(name: "NewPassword")
  final String newPassword;

  ChangePasswordRequestBody({
    required this.currentPassword,
    required this.newPassword,
  });

  factory ChangePasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestBodyToJson(this);
}
