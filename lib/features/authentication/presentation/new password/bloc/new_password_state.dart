part of 'new_password_bloc.dart';

@freezed
class NewPasswordState with _$NewPasswordState {
  const factory NewPasswordState.initial(
      {@Default(RequestStates.initial) RequestStates newPasswordState,
      String? errorMessage}) = _Initial;
}
