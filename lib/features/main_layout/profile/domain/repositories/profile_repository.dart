import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:tradehub/features/main_layout/profile/data/models/upload_profile_picture_response.dart';

abstract class ProfileRepository {
  Future<ApiResult<UploadProfilePictureResponse>> uploadProfilePicture(File image);
  Future<ApiResult<void>> deleteProfilePicture();
}

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<UploadProfilePictureResponse>> uploadProfilePicture(File image) {
    return _remoteDataSource.uploadProfilePicture(image);
  }

  @override
  Future<ApiResult<void>> deleteProfilePicture() {
    return _remoteDataSource.deleteProfilePicture();
  }
}
