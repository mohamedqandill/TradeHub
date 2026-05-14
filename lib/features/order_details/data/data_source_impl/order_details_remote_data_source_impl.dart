import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/order_details/data/api/order_details_api_client.dart';
import 'package:tradehub/features/order_details/data/data_source_contract/order_details_remote_data_source.dart';
import 'package:tradehub/features/order_details/data/models/order_details_response_d_t_o.dart';

@Injectable(as: OrderDetailsRemoteDataSource)
class OrderDetailsRemoteDataSourceImpl implements OrderDetailsRemoteDataSource {
  final OrderDetailsApiClient _apiClient;

  OrderDetailsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<OrderDetailsResponseDTO>> getOrderDetails(int id) {
    return ApiExecutor.executeApi(
      apiCall: () => _apiClient.getOrderDetails(id),
    );
  }
}
