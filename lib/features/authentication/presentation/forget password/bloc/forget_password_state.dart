part of 'forget_password_bloc.dart';

@freezed
class ForgetPasswordState with _$ForgetPasswordState {
  const factory ForgetPasswordState.initial({
    @Default(RequestStates.initial) RequestStates forgetPasswordState,
    String? message,
  }) = _Initial;
}
