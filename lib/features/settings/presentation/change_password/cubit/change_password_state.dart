import 'package:tradehub/core/api/api_errors/api_error_model.dart';

abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordError extends ChangePasswordState {
  final ErrorsModel error;

  ChangePasswordError(this.error);
}
