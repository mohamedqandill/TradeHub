import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';
import 'package:tradehub/features/product_ratings/domain/repo_contract/product_ratings_repository_contract.dart';

@injectable
class AddProductRatingUseCase {
  final ProductRatingsRepositoryContract _repo;

  AddProductRatingUseCase(this._repo);

  Future<ApiResult<ProductRatingDTO>> call({
    required int productId,
    required int ratingValue,
    required String comment,
  }) {
    return _repo.addProductRating(
      productId: productId,
      ratingValue: ratingValue,
      comment: comment,
    );
  }
}

