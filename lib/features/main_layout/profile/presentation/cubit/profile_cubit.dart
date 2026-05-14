import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/utils/storage/hive_storage.dart';
import 'package:tradehub/features/main_layout/profile/domain/use_cases/profile_picture_use_cases.dart';
import 'package:tradehub/features/main_layout/profile/presentation/cubit/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final UploadProfilePictureUseCase _uploadProfilePictureUseCase;
  final DeleteProfilePictureUseCase _deleteProfilePictureUseCase;
  final HiveStorageHelper _hiveStorageHelper;

  ProfileCubit(
    this._uploadProfilePictureUseCase,
    this._deleteProfilePictureUseCase,
    this._hiveStorageHelper,
  ) : super(ProfileInitial());

  Future<void> uploadProfilePicture(File image) async {
    emit(ProfilePictureUploadLoading());
    final result = await _uploadProfilePictureUseCase(image);

    switch (result) {
      case Success():
        final imageUrl = result.data?.imageUrl;
        // Cache the new image URL in user info
        if (imageUrl != null) {
          final userInfo =
              _hiveStorageHelper.getMap(AppConstants.userInfo) ?? {};
          userInfo["imageUrl"] = imageUrl;
          _hiveStorageHelper.saveMap(AppConstants.userInfo, userInfo);
        }
        emit(ProfilePictureUploadSuccess(imageUrl: imageUrl));
      case Error():
        emit(ProfilePictureUploadError(
            result.error?.message ?? "Failed to upload profile picture."));
    }
  }

  Future<void> deleteProfilePicture() async {
    emit(ProfilePictureDeleteLoading());
    final result = await _deleteProfilePictureUseCase();

    switch (result) {
      case Success():
        // Remove imageUrl from local cache
        final userInfo = _hiveStorageHelper.getMap(AppConstants.userInfo);
        if (userInfo != null) {
          userInfo.remove("imageUrl");
          _hiveStorageHelper.saveMap(AppConstants.userInfo, userInfo);
        }
        emit(ProfilePictureDeleteSuccess());
      case Error():
        emit(ProfilePictureDeleteError(
            result.error?.message ?? "Failed to delete profile picture."));
    }
  }
}
