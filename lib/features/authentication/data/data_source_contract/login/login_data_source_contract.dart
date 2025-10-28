import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/data/models/login/login_response_dto.dart';

import '../../models/login/login_request_body.dart';

abstract class LoginDataSourceContract {
  Future<ApiResult<LoginResponseDTO>> login(
      {required LoginRequestBody loginBody});
}
