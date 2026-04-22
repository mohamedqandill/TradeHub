import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';

import '../../../../core/api/api_result/api_result.dart';
import '../models/response/product_details_response_d_t_o.dart';

abstract class ProductDetailsDataSourceContract {
  Future<ApiResult<ProductDetailsResponseDTO>> getProductDetails(int id);
  Future<ApiResult<CartResponseDTO>> addToCart(int productId, {int quantity = 1});
  Future<ApiResult<void>> toggleFavorite(int productId);
}
