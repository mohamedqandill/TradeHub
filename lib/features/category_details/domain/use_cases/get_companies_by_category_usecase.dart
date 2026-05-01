import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/category_details/domain/entities/category_company_entity.dart';
import 'package:tradehub/features/category_details/domain/repos_contract/category_details_repo_contract.dart';

@injectable
class GetCompaniesByCategoryUseCase {
  final CategoryDetailsRepoContract _repo;

  GetCompaniesByCategoryUseCase(this._repo);

  Future<ApiResult<List<CategoryCompanyEntity>>> call(int categoryId) {
    return _repo.getCompaniesByCategory(categoryId);
  }
}

