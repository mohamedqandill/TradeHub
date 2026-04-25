import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';

abstract class ProductRatingsRepositoryContract {
  Future<ApiResult<List<ProductRatingDTO>>> getProductRatings(int productId);

  Future<ApiResult<ProductRatingDTO>> addProductRating({
    required int productId,
    required int ratingValue,
    required String comment,
  });
}

