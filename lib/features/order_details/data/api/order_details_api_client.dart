import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';
import 'package:tradehub/features/order_details/data/models/order_details_response_d_t_o.dart';

part 'order_details_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@injectable
abstract class OrderDetailsApiClient {
  @factoryMethod
  factory OrderDetailsApiClient(Dio dio, {@Named('baseUrl') String? baseUrl}) = _OrderDetailsApiClient;

  @GET("${ApiEndPoints.orders}{id}")
  Future<OrderDetailsResponseDTO> getOrderDetails(@Path("id") int id);

  @PUT(ApiEndPoints.cancelOrder)
  Future<void> cancelOrder(@Path('id') int id);
}

