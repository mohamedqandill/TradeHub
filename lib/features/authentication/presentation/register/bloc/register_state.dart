part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial(
      {@Default(RequestStates.initial) RequestStates registerState,
      String? errorMessage}) = _Initial;
}
