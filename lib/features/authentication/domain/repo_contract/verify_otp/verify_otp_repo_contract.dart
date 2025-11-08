import 'package:tradehub/core/api/api_result/api_result.dart';

import '../../../data/models/verify_otp/verify_o_t_p_body.dart';

abstract class VerifyOTPRepoContract {
  Future<ApiResult<void>> verifyOTP({required VerifyOTPBody verifyOTPBody});
}
