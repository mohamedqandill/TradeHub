import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/data/data_source_contract/new_password/new_password_data_source_contract.dart';
import 'package:tradehub/features/authentication/data/models/new_password/new_password_request_body.dart';
import 'package:tradehub/features/authentication/domain/repo_contract/new_password/new_password_repo_contract.dart';

@Injectable(as: NewPasswordRepoContract)
class NewPasswordRepoImpl implements NewPasswordRepoContract {
  final NewPasswordDataSourceContract _newPasswordDataSourceContract;
  NewPasswordRepoImpl(this._newPasswordDataSourceContract);
  @override
  Future<ApiResult<void>> newPassword(
      {required NewPasswordRequestBody body}) async {
    return await _newPasswordDataSourceContract.newPassword(body: body);
  }
}
