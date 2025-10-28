part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial(
      {@Default(RequestStates.initial) RequestStates loginState,
      String? errorMessage}) = _Initial;
}
