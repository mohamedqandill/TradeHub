import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/order_details/data/models/order_details_response_d_t_o.dart';

abstract class OrderDetailsRemoteDataSource {
  Future<ApiResult<OrderDetailsResponseDTO>> getOrderDetails(int id);
  Future<ApiResult<void>> cancelOrder({required int id});
}
