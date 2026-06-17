import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/your_orders/data/models/order_response_d_t_o.dart';

abstract class OrdersRepository {
  Future<ApiResult<OrderResponseDTO>> getOrders({
    String? orderStatus,
    int? pageIndex,
    int? pageSize,
  });

}
