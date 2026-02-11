// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_o_t_p_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOTPBody _$VerifyOTPBodyFromJson(Map<String, dynamic> json) =>
    VerifyOTPBody(
      phoneOrEmail: json['phoneOrEmail'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$VerifyOTPBodyToJson(VerifyOTPBody instance) =>
    <String, dynamic>{
      'phoneOrEmail': instance.phoneOrEmail,
      'code': instance.code,
    };
