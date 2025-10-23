import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/use_cases/register/register_use_case.dart';

import '../../../../../main.dart';
import '../../../data/models/register/register_body.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  RegisterBloc(this._registerUseCase) : super(const RegisterState.initial()) {
    on<Register>((event, emit) async {
      emit(state.copyWith(registerState: RequestStates.loading));
      var result =
          await _registerUseCase.call(registerBody: event.registerBody);
      switch (result) {
        case Success():
          emit(state.copyWith(registerState: RequestStates.success));
        case Error():
          emit(state.copyWith(
              registerState: RequestStates.error,
              errorMessage: result.error!.message));
      }
    });
  }
  @override
  Future<void> close() {
    email.dispose();
    phoneNumber.dispose();
    firstName.dispose();
    lastName.dispose();
    password.dispose();
    return super.close();
  }
}
