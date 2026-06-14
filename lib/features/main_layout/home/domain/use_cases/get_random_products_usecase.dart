import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_random_products_response_entity.dart';
import 'package:tradehub/features/main_layout/home/domain/repos_contract/home_repo_contract.dart';

@injectable
class GetRandomProductsUseCase {
  final HomeRepoContract _homeRepoContract;
  GetRandomProductsUseCase(this._homeRepoContract);

  Future<ApiResult<GetRandomProductsResponseEntity>> call({
    int? pageIndex,
    int? pageSize,
    String? sort,
  }) {
    return _homeRepoContract.getRandomProducts(
      pageIndex: pageIndex,
      pageSize: pageSize,
      sort: sort,
    );
  }
}
