import 'package:tradehub/core/api/api_result/api_result.dart';

import '../../../data/models/login/login_request_body.dart';

abstract class LoginRepoContract {
  Future<ApiResult<void>> login(
      {required LoginRequestBody loginBody, required bool isRememberMe});
}
