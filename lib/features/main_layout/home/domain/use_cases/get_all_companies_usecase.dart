import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_company_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/repos_contract/home_repo_contract.dart';

@injectable
class GetAllCompaniesUseCase {
  final HomeRepoContract _homeRepoContract;
  GetAllCompaniesUseCase(this._homeRepoContract);

  Future<ApiResult<List<GetCompanyEntity>>> call() {
    return _homeRepoContract.getCompanies();
  }
}
