import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';

import '../../data/models/response/product_details_response_d_t_o.dart';
import '../../data/models/response/product_option_response_dto.dart';

abstract class ProductDetailsRepositoryContract {
  Future<ApiResult<ProductDetailsResponseDTO>> getProductDetails(int id);
  Future<ApiResult<List<ProductOptionDTO>>> getProductOptions(int productId);
  Future<ApiResult<CartResponseDTO>> addToCart(int productId, {int quantity = 1, List<int>? selectedOptionValueIds});
}
