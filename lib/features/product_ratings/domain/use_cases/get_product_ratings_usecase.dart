import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';
import 'package:tradehub/features/product_ratings/domain/repo_contract/product_ratings_repository_contract.dart';

@injectable
class GetProductRatingsUseCase {
  final ProductRatingsRepositoryContract _repo;

  GetProductRatingsUseCase(this._repo);

  Future<ApiResult<List<ProductRatingDTO>>> call(int productId) {
    return _repo.getProductRatings(productId);
  }
}

