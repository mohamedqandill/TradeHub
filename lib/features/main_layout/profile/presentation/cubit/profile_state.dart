sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class ProfilePictureUploadLoading extends ProfileState {}

class ProfilePictureUploadSuccess extends ProfileState {
  final String? imageUrl;
  ProfilePictureUploadSuccess({this.imageUrl});
}

class ProfilePictureUploadError extends ProfileState {
  final String message;
  ProfilePictureUploadError(this.message);
}

class ProfilePictureDeleteLoading extends ProfileState {}

class ProfilePictureDeleteSuccess extends ProfileState {}

class ProfilePictureDeleteError extends ProfileState {
  final String message;
  ProfilePictureDeleteError(this.message);
}
