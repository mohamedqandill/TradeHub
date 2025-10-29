part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial(
      {@Default(RequestStates.initial) RequestStates loginState,
      @Default(RequestStates.initial) RequestStates signWithFacebookState,
      @Default(RequestStates.initial) RequestStates signWithGoogleState,
      String? errorMessage}) = _Initial;
}
