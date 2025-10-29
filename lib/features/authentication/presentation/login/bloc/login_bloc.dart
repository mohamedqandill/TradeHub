import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/data/models/login/login_request_body.dart';
import 'package:tradehub/features/authentication/domain/use_cases/login/login_use_case.dart';
import 'package:tradehub/main.dart';

import '../../../domain/use_cases/sign_with_facebook_use_case.dart';
import '../../../domain/use_cases/sign_with_google_use_case.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final SignWithGoogleUseCase _signWithGoogleUseCase;
  final SignWithFacebookUseCase _signWithFacebookUseCase;

  final email = TextEditingController();
  final password = TextEditingController();
  bool isRememberMe = false;
  bool isObscureText = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginBloc(this._loginUseCase, this._signWithGoogleUseCase,
      this._signWithFacebookUseCase)
      : super(const LoginState.initial()) {
    on<Login>((event, emit) async {
      emit(state.copyWith(loginState: RequestStates.loading));
      var result = await _loginUseCase(
          loginBody:
              LoginRequestBody(email: email.text, password: password.text),
          isRememberMe: isRememberMe);
      switch (result) {
        case Success():
          emit(state.copyWith(loginState: RequestStates.success));
        case Error():
          emit(state.copyWith(
              loginState: RequestStates.error,
              errorMessage: result.error!.message));
      }
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
    on<SignWithFacebook>((event, emit) async {
      emit(state.copyWith(signWithFacebookState: RequestStates.loading));

      var result = await _signWithFacebookUseCase.call();
      switch (result) {
        case Success():
          emit(state.copyWith(signWithFacebookState: RequestStates.success));
        case Error():
          emit(state.copyWith(
              signWithFacebookState: RequestStates.error,
              errorMessage: result.error!.message));
      }
    });
  }
}
