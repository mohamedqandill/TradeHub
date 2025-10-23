import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/entites/register/register_entity.dart';
import 'package:tradehub/features/authentication/domain/repo_contract/register/register_repo.dart';

import '../../../data/models/register/register_body.dart';

@injectable
class RegisterUseCase {
  final RegisterRepo _registerRepo;

  RegisterUseCase(this._registerRepo);

  Future<ApiResult<RegisterEntity>> call(
          {required RegisterBody registerBody}) async =>
      await _registerRepo.register(registerBody: registerBody);
}
