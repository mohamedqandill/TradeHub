import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/repo_contract/verify_otp/verify_otp_repo_contract.dart';

import '../../../data/models/verify_o_t_p_body.dart';

@injectable
class VerifyOTPUseCase {
  final VerifyOTPRepoContract _repo;

  VerifyOTPUseCase(this._repo);

  Future<ApiResult<void>> call({required VerifyOTPBody verifyOTPBody}) async =>
      await _repo.verifyOTP(verifyOTPBody: verifyOTPBody);
}
