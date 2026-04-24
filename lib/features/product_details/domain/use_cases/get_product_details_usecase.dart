import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result/api_result.dart';
import '../../data/models/response/product_details_response_d_t_o.dart';
import '../repo_contract/product_details_repository_contract.dart';

@injectable
class GetProductDetailsUseCase {
  final ProductDetailsRepositoryContract _repository;

  GetProductDetailsUseCase(this._repository);

  Future<ApiResult<ProductDetailsResponseDTO>> call(int id) {
    return _repository.getProductDetails(id);
  }
}
