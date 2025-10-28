import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/data/data_source_contract/register/register_data_source.dart';
import 'package:tradehub/features/authentication/data/models/register/register_body.dart';
import 'package:tradehub/features/authentication/domain/entites/register/register_entity.dart';
import 'package:tradehub/features/authentication/domain/repo_contract/register/register_repo.dart';

@Injectable(as: RegisterRepo)
class RegisterRepoImpl implements RegisterRepo {
  RegisterDataSource _registerDataSource;
  RegisterRepoImpl(this._registerDataSource);
  @override
  Future<ApiResult<RegisterEntity>> register(
      {required RegisterBody registerBody}) async {
    return await _registerDataSource.register(registerBody: registerBody);
  }

  @override
  Future<ApiResult<String>> sendOTP({required String email}) async {
    return await _registerDataSource.sendOTP(email: email);
  }

  @override
  Future<ApiResult<String>> verifyAccount(
      {required String email, required String phone}) async {
    return await _registerDataSource.verifyAccount(email: email, phone: phone);
  }

  @override
  Future<ApiResult<void>> signWithGoogle() async {
    return await _registerDataSource.signWithGoogle();
  }

  @override
  Future<ApiResult<void>> signWithFacebook() async {
    return await _registerDataSource.signWithFacebook();
  }
}
