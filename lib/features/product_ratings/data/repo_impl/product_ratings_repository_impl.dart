import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/product_ratings/data/data_source_contract/product_ratings_data_source_contract.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';
import 'package:tradehub/features/product_ratings/domain/repo_contract/product_ratings_repository_contract.dart';

@Injectable(as: ProductRatingsRepositoryContract)
class ProductRatingsRepositoryImpl extends ProductRatingsRepositoryContract {
  final ProductRatingsDataSourceContract _dataSource;

  ProductRatingsRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<List<ProductRatingDTO>>> getProductRatings(int productId) {
    return _dataSource.getProductRatings(productId);
  }

  @override
  Future<ApiResult<ProductRatingDTO>> addProductRating({
    required int productId,
    required int ratingValue,
    required String comment,
  }) {
    return _dataSource.addProductRating(
      productId: productId,
      ratingValue: ratingValue,
      comment: comment,
    );
  }
}

