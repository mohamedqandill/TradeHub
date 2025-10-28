import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/use_cases/register/register_use_case.dart';
import 'package:tradehub/features/authentication/domain/use_cases/register/send_otp_use_case.dart';
import 'package:tradehub/features/authentication/domain/use_cases/register/verify_account_use_case.dart';
import 'package:tradehub/features/authentication/domain/use_cases/sign_with_google_use_case.dart';

import '../../../../../main.dart';
import '../../../data/models/register/register_body.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  final SendOTPUseCase _sendOTPUseCase;
  final VerifyAccountUseCase _verifyAccountUseCase;
  final SignWithGoogleUseCase _signWithGoogleUseCase;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  bool isRememberMe = false;
  bool isObscureText = false;
  double spaceHeight = 16.h;
  double? waveHeight;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegisterBloc(this._registerUseCase, this._sendOTPUseCase,
      this._verifyAccountUseCase, this._signWithGoogleUseCase)
      : super(const RegisterState.initial()) {
    on<Register>((event, emit) async {
      emit(state.copyWith(registerState: RequestStates.loading));
      var result = await _registerUseCase.call(
          registerBody: RegisterBody(
              email: email.text,
              password: password.text,
              firstName: firstName.text,
              lastName: lastName.text,
              phoneNumber: phoneNumber.text));
      switch (result) {
        case Success():
          emit(state.copyWith(registerState: RequestStates.success));
        case Error():
          emit(state.copyWith(
              registerState: RequestStates.error,
              errorMessage: result.error!.message));
      }
    });
    on<SendOTP>((event, emit) async {
      emit(state.copyWith(sendOTPState: RequestStates.loading));
      var result = await _sendOTPUseCase.call(email: email.text);
      switch (result) {
        case Success():
          emit(state.copyWith(sendOTPState: RequestStates.success));
        case Error():
          emit(state.copyWith(
              sendOTPState: RequestStates.error,
              errorMessage: result.error!.message));
      }
    });
    on<VerifyAccount>((event, emit) async {
      await _verifyAccountUseCase.call(
          email: email.text, phone: phoneNumber.text);
    });
    on<SignWithGoogle>((event, emit) async {
      emit(state.copyWith(signWithGoogleState: RequestStates.loading));

      var result = await _signWithGoogleUseCase.call();
      switch (result) {
        case Success():
          emit(state.copyWith(signWithGoogleState: RequestStates.success));
        case Error():
          emit(state.copyWith(
              signWithGoogleState: RequestStates.error,
              errorMessage: result.error!.message));
      }
    });
  }

  @override
  Future<void> close() {
    email.dispose();
    phoneNumber.dispose();
    firstName.dispose();
    lastName.dispose();
    password.dispose();
    return super.close();
  }
}
