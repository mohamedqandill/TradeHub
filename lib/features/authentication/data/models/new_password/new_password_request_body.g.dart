// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_password_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewPasswordRequestBody _$NewPasswordRequestBodyFromJson(
        Map<String, dynamic> json) =>
    NewPasswordRequestBody(
      Email: json['Email'] as String?,
      otpCode: json['otpCode'] as String?,
      NewPassword: json['NewPassword'] as String?,
    );

Map<String, dynamic> _$NewPasswordRequestBodyToJson(
        NewPasswordRequestBody instance) =>
    <String, dynamic>{
      'Email': instance.Email,
      'otpCode': instance.otpCode,
      'NewPassword': instance.NewPassword,
    };
