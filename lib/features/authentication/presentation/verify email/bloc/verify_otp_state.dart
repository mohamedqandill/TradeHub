part of 'verify_otp_bloc.dart';

@freezed
class VerifyOtpState with _$VerifyOtpState {
  const factory VerifyOtpState.initial(
      {@Default(RequestStates.initial) RequestStates verifyOTPStates,
      String? errorMessage}) = _Initial;
}
