import '../../../../../core/api/api_result/api_result.dart';
import '../../data/models/cart_response_d_t_o.dart';
import '../../data/models/update_item_quantity_body.dart';

abstract class CartRepoContract {
  Future<ApiResult<CartResponseDTO>> getBasket();
  Future<ApiResult<void>> removeBasket();
  Future<ApiResult<void>> removeItem(int id);
  Future<ApiResult<void>> updateItemQuantity({required int id, required int quantity});
}
