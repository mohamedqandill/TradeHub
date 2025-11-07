import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/use_cases/verify_otp/verify_otp_use_case.dart';
import 'package:tradehub/main.dart';

import '../../../data/models/verify_o_t_p_body.dart';

part 'verify_otp_bloc.freezed.dart';
part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

@injectable
class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final VerifyOTPUseCase _verifyOTPUseCase;
  late String userEmail;
  VerifyOtpBloc(this._verifyOTPUseCase)
      : super(const VerifyOtpState.initial()) {
    on<VerifyOTP>((event, emit) async {
      emit(state.copyWith(verifyOTPStates: RequestStates.loading));
      var result =
          await _verifyOTPUseCase.call(verifyOTPBody: event.verifyOTPBody);
      switch (result) {
        case Success():
          emit(state.copyWith(verifyOTPStates: RequestStates.success));
        case Error():
          emit(state.copyWith(
              verifyOTPStates: RequestStates.error,
              errorMessage: result.error!.message.toString()));
      }
    });
  }
  getEmail({required String email}) {
    userEmail = email;
  }
}
