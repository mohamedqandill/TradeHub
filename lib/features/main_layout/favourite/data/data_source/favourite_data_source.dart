import 'package:injectable/injectable.dart';
import '../../../../../core/api/api_executor/api_executor.dart';
import '../../../../../core/api/api_result/api_result.dart';
import '../api/favourite_api_client.dart';
import '../models/get_favorite_products_response_d_t_o.dart';

abstract class FavouriteDataSource {
  Future<ApiResult<GetFavoriteProductsResponseDTO>> getFavorites();
  Future<ApiResult<void>> toggleFavorite(int id);
}

@Injectable(as: FavouriteDataSource)
class FavouriteDataSourceImpl implements FavouriteDataSource {
  final FavouriteApiClient _apiClient;

  FavouriteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<GetFavoriteProductsResponseDTO>> getFavorites() async {
    return await ApiExecutor.executeApi(
      apiCall: () => _apiClient.getFavorites(),
    );
  }

  @override
  Future<ApiResult<void>> toggleFavorite(int id) async {
    return await ApiExecutor.executeApi(
      apiCall: () => _apiClient.toggleFavorite(id),
    );
  }
}
