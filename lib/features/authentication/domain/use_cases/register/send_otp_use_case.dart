import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/domain/repo_contract/register/register_repo.dart';

@injectable
class SendOTPUseCase {
  final RegisterRepo _registerRepo;

  SendOTPUseCase(this._registerRepo);

  Future<ApiResult<String>> call({required String email}) async =>
      await _registerRepo.sendOTP(email: email);
}
