import 'package:injectable/injectable.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';
import '../../../../core/api/api_result/api_result.dart';
import '../repo_contract/product_details_repository_contract.dart';

@injectable
class AddToCartUseCase {
  final ProductDetailsRepositoryContract _repository;

  AddToCartUseCase(this._repository);

  Future<ApiResult< CartResponseDTO>> call(int productId, {int quantity = 1, List<int>? selectedOptionValueIds}) {
    return _repository.addToCart(productId, quantity: quantity, selectedOptionValueIds: selectedOptionValueIds);
  }
}
