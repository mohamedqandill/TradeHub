import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result/api_result.dart';
import '../repo_contract/product_details_repository_contract.dart';

@injectable
class ToggleFavoriteUseCase {
  final ProductDetailsRepositoryContract _repository;

  ToggleFavoriteUseCase(this._repository);

  Future<ApiResult<void>> call(int productId) {
    return _repository.toggleFavorite(productId);
  }
}
