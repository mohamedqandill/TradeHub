import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import '../api/orders_api_client.dart';
import '../data_source_contract/orders_data_source.dart';
import '../models/order_response_d_t_o.dart';

@Injectable(as: OrdersDataSource)
class OrdersDataSourceImpl implements OrdersDataSource {
  final OrdersApiClient _apiClient;

  OrdersDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<List<OrderResponseDTO>>> getOrders() async {
    return await ApiExecutor.executeApi<List<OrderResponseDTO>>(
      apiCall: () => _apiClient.getOrders(),
    );
  }
}
