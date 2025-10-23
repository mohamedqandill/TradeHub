import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/entites/register/register_entity.dart';

import '../../models/register/register_body.dart';

abstract class RegisterDataSource {
  Future<ApiResult<RegisterEntity>> register(
      {required RegisterBody registerBody});
}
