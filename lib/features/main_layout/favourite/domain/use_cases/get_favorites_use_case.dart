import 'package:injectable/injectable.dart';
import '../../../../../core/api/api_result/api_result.dart';
import '../entites/favourite_product_entity.dart';
import '../repos_contract/favourite_repo_contract.dart';

@injectable
class GetFavoritesUseCase {
  final FavouriteRepoContract _repo;

  GetFavoritesUseCase(this._repo);

  Future<ApiResult<List<FavoriteProductEntity>>> call() async {
    return await _repo.getFavorites();
  }
}
