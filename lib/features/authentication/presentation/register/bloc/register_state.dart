part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial(
      {@Default(RequestStates.initial) RequestStates registerState,
      @Default(RequestStates.initial) RequestStates sendOTPState,
      @Default(RequestStates.initial) RequestStates signWithGoogleState,
      @Default(RequestStates.initial) RequestStates signWithFacebookState,
      String? errorMessage}) = _Initial;
}
