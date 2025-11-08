import 'package:tradehub/core/api/api_result/api_result.dart';

import '../../models/new_password/new_password_request_body.dart';

abstract class NewPasswordDataSourceContract {
  Future<ApiResult<void>> newPassword({required NewPasswordRequestBody body});
}
