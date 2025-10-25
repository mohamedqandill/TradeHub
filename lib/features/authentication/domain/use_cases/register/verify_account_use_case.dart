import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/repo_contract/register/register_repo.dart';

@injectable
class VerifyAccountUseCase {
  final RegisterRepo _registerRepo;

  VerifyAccountUseCase(this._registerRepo);

  Future<ApiResult<String>> call(
          {required String email, required String phone}) async =>
      await _registerRepo.verifyAccount(email: email, phone: phone);
}
