import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/repo_contract/new_password/new_password_repo_contract.dart';

import '../../../data/models/new_password/new_password_request_body.dart';

@injectable
class NewPasswordUseCase {
  final NewPasswordRepoContract _newPasswordRepoContract;

  NewPasswordUseCase(this._newPasswordRepoContract);

  Future<ApiResult<void>> call({required NewPasswordRequestBody body}) =>
      _newPasswordRepoContract.newPassword(body: body);
}
