import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/data/models/new_password/new_password_request_body.dart';
import 'package:tradehub/features/authentication/domain/use_cases/new_password/new_password_use_case.dart';
import 'package:tradehub/main.dart';

import '../../verify email/view/widgets/pin_put.dart';

part 'new_password_bloc.freezed.dart';
part 'new_password_event.dart';
part 'new_password_state.dart';

@injectable
class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  final NewPasswordUseCase _newPasswordUseCase;
  late String userEmail;
  late String code;
  bool isVisible = false;
  final newPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  NewPasswordBloc(this._newPasswordUseCase)
      : super(const NewPasswordState.initial()) {
    on<NewPassword>((event, emit) async {
      emit(state.copyWith(newPasswordState: RequestStates.loading));
      var result = await _newPasswordUseCase.call(
          body: NewPasswordRequestBody(
              Email: userEmail, NewPassword: newPassword.text, otpCode: code));
      switch (result) {
        case Success():
          emit(state.copyWith(newPasswordState: RequestStates.success));
        case Error():
          emit(state.copyWith(
              newPasswordState: RequestStates.error,
              errorMessage: result.error!.message.toString()));
      }
    });
  }
  getEmailAndeCode({required UserEmailAndCode body}) {
    userEmail = body.email;
    code = body.code;
  }
}
