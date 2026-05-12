import 'package:tradehub/core/api/api_result/api_result.dart';
import '../models/order_response_d_t_o.dart';

abstract class OrdersDataSource {
  Future<ApiResult<List<OrderResponseDTO>>> getOrders();
}
