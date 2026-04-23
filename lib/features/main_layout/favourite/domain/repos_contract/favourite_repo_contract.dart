import '../../../../../core/api/api_result/api_result.dart';
import '../entites/favourite_product_entity.dart';

abstract class FavouriteRepoContract {
  Future<ApiResult<List<FavoriteProductEntity>>> getFavorites();
  Future<ApiResult<void>> toggleFavorite(int id);
}
