// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseDTO _$LoginResponseDTOFromJson(Map<String, dynamic> json) =>
    LoginResponseDTO(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      loginProvider: json['LoginProvider'] as String?,
      token: json['token'] as String?,
      refreshTokenExpiration: json['refreshTokenExpiration'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$LoginResponseDTOToJson(LoginResponseDTO instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'roles': instance.roles,
      'LoginProvider': instance.loginProvider,
      'token': instance.token,
      'refreshTokenExpiration': instance.refreshTokenExpiration,
      'profilePicture': instance.profilePicture,
    };
