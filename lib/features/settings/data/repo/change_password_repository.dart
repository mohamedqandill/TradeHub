import 'package:tradehub/core/api/api_result/api_result.dart';
import '../models/change_password_request_body.dart';

abstract class ChangePasswordRepository {
  Future<ApiResult<void>> changePassword({required ChangePasswordRequestBody body});
}
