import 'package:tradehub/core/api/api_result/api_result.dart';
import '../models/order_response_d_t_o.dart';

abstract class OrdersDataSource {
  Future<ApiResult<OrderResponseDTO>> getOrders({
    String? orderStatus,
    int? pageIndex,
    int? pageSize,
  });

}
