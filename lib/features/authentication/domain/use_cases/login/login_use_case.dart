import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/repo_contract/login/login_repo_contract.dart';

import '../../../data/models/login/login_request_body.dart';

@injectable
class LoginUseCase {
  final LoginRepoContract _loginRepoContract;

  LoginUseCase(this._loginRepoContract);

  Future<ApiResult<void>> call(
          {required LoginRequestBody loginBody,
          required bool isRememberMe}) async =>
      await _loginRepoContract.login(
          loginBody: loginBody, isRememberMe: isRememberMe);
}
