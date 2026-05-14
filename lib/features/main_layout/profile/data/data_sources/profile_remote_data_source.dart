import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/profile/data/api/profile_api_client.dart';
import 'package:tradehub/features/main_layout/profile/data/models/upload_profile_picture_response.dart';

abstract class ProfileRemoteDataSource {
  Future<ApiResult<UploadProfilePictureResponse>> uploadProfilePicture(File image);
  Future<ApiResult<void>> deleteProfilePicture();
}

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<UploadProfilePictureResponse>> uploadProfilePicture(File image) {
    return ApiExecutor.executeApi(
      apiCall: () => _apiClient.uploadProfilePicture(image),
    );
  }

  @override
  Future<ApiResult<void>> deleteProfilePicture() {
    return ApiExecutor.executeApi(
      apiCall: () => _apiClient.deleteProfilePicture(),
    );
  }
}
