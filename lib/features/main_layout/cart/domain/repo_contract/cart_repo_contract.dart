import '../../../../../core/api/api_result/api_result.dart';
import '../../data/models/cart_response_d_t_o.dart';

abstract class CartRepoContract {
  Future<ApiResult<List<CartResponseDTO>>> getBasket();
  Future<ApiResult<void>> removeBasket();
  Future<ApiResult<void>> removeItem({required int companyId, required int productId});
  Future<ApiResult<void>> updateItemQuantity({required int companyId, required int productId, required int quantity});
}

