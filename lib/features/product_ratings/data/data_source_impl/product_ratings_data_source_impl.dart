import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/product_ratings/data/api/product_ratings_api_client.dart';
import 'package:tradehub/features/product_ratings/data/data_source_contract/product_ratings_data_source_contract.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';

@Injectable(as: ProductRatingsDataSourceContract)
class ProductRatingsDataSourceImpl extends ProductRatingsDataSourceContract {
  final ProductRatingsApiClient _apiClient;

  ProductRatingsDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<List<ProductRatingDTO>>> getProductRatings(int productId) {
    return ApiExecutor.executeApi<List<ProductRatingDTO>>(
      apiCall: () => _apiClient.getProductRatings(productId),
    );
  }

  @override
  Future<ApiResult<ProductRatingDTO>> addProductRating({
    required int productId,
    required int ratingValue,
    required String comment,
  }) {
    return ApiExecutor.executeApi<ProductRatingDTO>(
      apiCall: () => _apiClient.addProductRating(productId, {
        ApiConstants.ratingValue: ratingValue,
        ApiConstants.comment: comment,
      }),
    );
  }
}
