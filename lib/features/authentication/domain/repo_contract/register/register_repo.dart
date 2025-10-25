import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/entites/register/register_entity.dart';

import '../../../data/models/register/register_body.dart';

abstract class RegisterRepo {
  Future<ApiResult<RegisterEntity>> register(
      {required RegisterBody registerBody});
  Future<ApiResult<String>> sendOTP({required String email});
  Future<ApiResult<String>> verifyAccount(
      {required String email, required String phone});
}
