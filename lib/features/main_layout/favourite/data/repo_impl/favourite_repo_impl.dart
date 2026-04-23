import 'package:injectable/injectable.dart';
import '../../../../../core/api/api_result/api_result.dart';
import '../../domain/entites/favourite_product_entity.dart';
import '../../domain/repos_contract/favourite_repo_contract.dart';
import '../data_source/favourite_data_source.dart';

@Injectable(as: FavouriteRepoContract)
class FavouriteRepoImpl implements FavouriteRepoContract {
  final FavouriteDataSource _dataSource;

  FavouriteRepoImpl(this._dataSource);

  @override
  Future<ApiResult<List<FavoriteProductEntity>>> getFavorites() async {
    var result = await _dataSource.getFavorites();
    switch (result) {
      case Success():
        return Success(
          data: result.data?.data?.map((e) => e.toEntity()).toList() ?? [],
        );
      case Error():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<void>> toggleFavorite(int id) async {
    return await _dataSource.toggleFavorite(id);
  }
}
