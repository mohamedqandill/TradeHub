import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/repo_contract/register/register_repo.dart';

@injectable
class SignWithFacebookUseCase {
  final RegisterRepo _registerRepo;

  SignWithFacebookUseCase(this._registerRepo);

  Future<ApiResult<void>> call() async =>
      await _registerRepo.signWithFacebook();
}
