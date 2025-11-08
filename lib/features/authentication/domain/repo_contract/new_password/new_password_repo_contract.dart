import 'package:tradehub/core/api/api_result/api_result.dart';

import '../../../data/models/new_password/new_password_request_body.dart';

abstract class NewPasswordRepoContract {
  Future<ApiResult<void>> newPassword({required NewPasswordRequestBody body});
}
