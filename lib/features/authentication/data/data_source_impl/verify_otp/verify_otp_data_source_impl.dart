import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/data/api/api_client.dart';

import '../../data_source_contract/verify_otp/verify_otp_data_source_contract.dart';
import '../../models/verify_o_t_p_body.dart';

@Injectable(as: VerifyOTPDataSourceContract)
class VerifyOTPDataSourceImpl implements VerifyOTPDataSourceContract {
  final AuthApiClient _authApiClient;

  VerifyOTPDataSourceImpl(this._authApiClient);

  @override
  Future<ApiResult<void>> verifyOTP(
      {required VerifyOTPBody verifyOTPBody}) async {
    var result = await ApiExecutor.executeApi(
      apiCall: () => _authApiClient.verifyOTP(verifyOTPBody: verifyOTPBody),
    );
    switch (result) {
      case Success():
        return Success(data: null);
      case Error():
        return Error(error: result.error);
    }
  }
}
