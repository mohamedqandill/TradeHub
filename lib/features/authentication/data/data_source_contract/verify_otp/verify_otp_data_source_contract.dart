import 'package:tradehub/core/api/api_result/api_result.dart';

import '../../models/verify_otp/verify_o_t_p_body.dart';

abstract class VerifyOTPDataSourceContract {
  Future<ApiResult<void>> verifyOTP({required VerifyOTPBody verifyOTPBody});
}
