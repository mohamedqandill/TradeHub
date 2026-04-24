import '../../../../../core/api/api_result/api_result.dart';
import '../models/cart_response_d_t_o.dart';

abstract class CartDataSourceContract {
  Future<ApiResult<CartResponseDTO>> getBasket();
  Future<ApiResult<void>> removeBasket();
  Future<ApiResult<void>> removeItem(int id);
  Future<ApiResult<void>> updateItemQuantity({required int id, required int quantity});
}
