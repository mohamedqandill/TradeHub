import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/features/authentication/domain/use_cases/register/send_otp_use_case.dart';
import 'package:tradehub/main.dart';

import '../../../../../core/api/api_result/api_result.dart';

part 'forget_password_bloc.freezed.dart';
part 'forget_password_event.dart';
part 'forget_password_state.dart';

@injectable
class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final SendOTPUseCase _sendOTPUseCase;
  final TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ForgetPasswordBloc(this._sendOTPUseCase)
      : super(const ForgetPasswordState.initial()) {
    on<SendOTP>((event, emit) async {
      emit(state.copyWith(forgetPasswordState: RequestStates.loading));
      var result = await _sendOTPUseCase.call(email: event.email ?? email.text);
      switch (result) {
        case Success():
          emit(state.copyWith(
              forgetPasswordState: RequestStates.success,
              message: result.data));
        case Error():
          emit(state.copyWith(
              forgetPasswordState: RequestStates.error,
              message: result.error!.message));
      }
    });
  }
}
