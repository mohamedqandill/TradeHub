import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result/api_result.dart';
import '../../data/models/response/product_option_response_dto.dart';
import '../repo_contract/product_details_repository_contract.dart';

@injectable
class GetProductOptionsUseCase {
  final ProductDetailsRepositoryContract _repository;

  GetProductOptionsUseCase(this._repository);

  Future<ApiResult<List<ProductOptionDTO>>> call(int productId) {
    return _repository.getProductOptions(productId);
  }
}
