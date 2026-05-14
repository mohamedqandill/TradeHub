// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_profile_picture_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadProfilePictureResponse _$UploadProfilePictureResponseFromJson(
        Map<String, dynamic> json) =>
    UploadProfilePictureResponse(
      message: json['message'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$UploadProfilePictureResponseToJson(
        UploadProfilePictureResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'imageUrl': instance.imageUrl,
    };
