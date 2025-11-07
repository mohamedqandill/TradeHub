part of 'verify_otp_bloc.dart';

@freezed
class VerifyOtpEvent with _$VerifyOtpEvent {
  const factory VerifyOtpEvent.started() = _Started;
  const factory VerifyOtpEvent.verifyOtp(
      {required VerifyOTPBody verifyOTPBody}) = VerifyOTP;
}
