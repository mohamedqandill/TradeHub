import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/repo_contract/verify_otp/verify_otp_repo_contract.dart';

import '../../data_source_contract/verify_otp/verify_otp_data_source_contract.dart';
import '../../models/verify_otp/verify_o_t_p_body.dart';

@Injectable(as: VerifyOTPRepoContract)
class VerifyOTPRepoImpl implements VerifyOTPRepoContract {
  final VerifyOTPDataSourceContract _dataSourceContract;
  VerifyOTPRepoImpl(this._dataSourceContract);

  @override
  Future<ApiResult<void>> verifyOTP(
      {required VerifyOTPBody verifyOTPBody}) async {
    return await _dataSourceContract.verifyOTP(verifyOTPBody: verifyOTPBody);
  }
}
