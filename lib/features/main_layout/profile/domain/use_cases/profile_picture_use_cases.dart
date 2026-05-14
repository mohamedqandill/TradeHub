import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/profile/data/models/upload_profile_picture_response.dart';
import 'package:tradehub/features/main_layout/profile/domain/repositories/profile_repository.dart';

@injectable
class UploadProfilePictureUseCase {
  final ProfileRepository _repository;

  UploadProfilePictureUseCase(this._repository);

  Future<ApiResult<UploadProfilePictureResponse>> call(File image) {
    return _repository.uploadProfilePicture(image);
  }
}

@injectable
class DeleteProfilePictureUseCase {
  final ProfileRepository _repository;

  DeleteProfilePictureUseCase(this._repository);

  Future<ApiResult<void>> call() {
    return _repository.deleteProfilePicture();
  }
}
