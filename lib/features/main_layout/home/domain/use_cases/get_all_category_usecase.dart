import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_category_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/repos_contract/home_repo_contract.dart';

@injectable
class GetAllCategoryUseCase {
  final HomeRepoContract _homeRepoContract;
  GetAllCategoryUseCase(this._homeRepoContract);

  Future<ApiResult<List<GetCategoryEntity>>> call() {
    return _homeRepoContract.getCategory();
  }
}
