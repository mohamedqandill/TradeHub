import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';
import 'package:tradehub/features/main_layout/profile/data/models/upload_profile_picture_response.dart';

part 'profile_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@injectable
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio, {@Named('baseUrl') String? baseUrl}) =
      _ProfileApiClient;

  @POST(ApiEndPoints.uploadProfilePicture)
  @MultiPart()
  Future<UploadProfilePictureResponse> uploadProfilePicture(
      @Part(name: "image") File image);

  @DELETE(ApiEndPoints.deleteProfilePicture)
  Future<void> deleteProfilePicture();
}
