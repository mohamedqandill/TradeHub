part of 'forget_password_bloc.dart';

@freezed
class ForgetPasswordEvent with _$ForgetPasswordEvent {
  const factory ForgetPasswordEvent.started() = _Started;
  const factory ForgetPasswordEvent.sendOTP() = SendOTP;
}
