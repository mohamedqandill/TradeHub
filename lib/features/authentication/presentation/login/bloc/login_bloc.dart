import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/data/models/login/login_request_body.dart';
import 'package:tradehub/features/authentication/domain/use_cases/login/login_use_case.dart';
import 'package:tradehub/main.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final email = TextEditingController();
  final password = TextEditingController();
  bool isRememberMe = false;
  bool isObscureText = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginBloc(this._loginUseCase) : super(const LoginState.initial()) {
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
  }
}
