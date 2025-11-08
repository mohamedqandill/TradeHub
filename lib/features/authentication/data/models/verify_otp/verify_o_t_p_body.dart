import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/api/api_constant/api_constant.dart';

part 'verify_o_t_p_body.g.dart';

@JsonSerializable()
class VerifyOTPBody {
  @JsonKey(name: ApiConstants.phoneOrEmailSmall)
  final String? phoneOrEmail;
  @JsonKey(name: ApiConstants.code)
  final String? code;

  const VerifyOTPBody({
    this.phoneOrEmail,
    this.code,
  });

  factory VerifyOTPBody.fromJson(Map<String, dynamic> json) =>
      _$VerifyOTPBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOTPBodyToJson(this);
}
