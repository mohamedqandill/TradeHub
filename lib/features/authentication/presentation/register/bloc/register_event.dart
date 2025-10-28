part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.started() = _Started;

  const factory RegisterEvent.register() = Register;

  const factory RegisterEvent.sendOTP() = SendOTP;
  const factory RegisterEvent.verifyAccount() = VerifyAccount;
  const factory RegisterEvent.signWithGoogle() = SignWithGoogle;
  const factory RegisterEvent.signWithFacebook() = SignWithFacebook;
}
