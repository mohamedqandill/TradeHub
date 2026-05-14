import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';
import '../models/order_response_d_t_o.dart';

part 'orders_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@injectable
abstract class OrdersApiClient {
  @factoryMethod
  factory OrdersApiClient(Dio dio,{@Named('baseUrl') String? baseUrl}) = _OrdersApiClient;

  @GET(ApiEndPoints.orders)
  Future<List<OrderResponseDTO>> getOrders();
}
