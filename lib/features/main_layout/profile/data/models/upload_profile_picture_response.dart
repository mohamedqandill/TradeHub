import 'package:json_annotation/json_annotation.dart';

part 'upload_profile_picture_response.g.dart';

@JsonSerializable()
class UploadProfilePictureResponse {
  final String message;
  final String imageUrl;

  UploadProfilePictureResponse({
    required this.message,
    required this.imageUrl,
  });

  factory UploadProfilePictureResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadProfilePictureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadProfilePictureResponseToJson(this);
}
