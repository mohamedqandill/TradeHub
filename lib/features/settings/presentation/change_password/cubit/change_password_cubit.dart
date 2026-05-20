import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../../../data/models/change_password_request_body.dart';
import '../../../data/repo/change_password_repository.dart';
import 'change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordRepository _repository;

  ChangePasswordCubit(this._repository) : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());
    final body = ChangePasswordRequestBody(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    final result = await _repository.changePassword(body: body);
    switch (result) {
      case Success():
        emit(ChangePasswordSuccess());
      case Error():
        emit(ChangePasswordError(result.error!));
    }
  }
}
