import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/features/main_layout/cart/data/models/update_item_quantity_body.dart';

import '../../../../../core/api/api_endpoints/api_endpoints.dart';
import '../models/cart_response_d_t_o.dart';

part 'cart_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@singleton
@injectable
abstract class CartApiClient {
  @factoryMethod
  factory CartApiClient(Dio dio, {@Named('baseUrl') String? baseUrl}) = _CartApiClient;

  @GET(ApiEndPoints.basket)
  Future<CartResponseDTO> getBasket();

  @DELETE(ApiEndPoints.basket)
  Future<void> removeBasket();

  @DELETE("${ApiEndPoints.basketItems}{id}")
  Future<void> removeItem(@Path("id") int id);

  @PUT("${ApiEndPoints.basketItems}{id}")
  Future<void> updateItemQuantity( @Path("id") int id);
}
