import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/features/main_layout/cart/data/models/update_item_quantity_body.dart';

import '../../../../../core/api/api_endpoints/api_endpoints.dart';
import '../models/cart_response_d_t_o.dart';

part 'cart_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@singleton
@injectable
abstract class CartApiClient {
  @factoryMethod
  factory CartApiClient(Dio dio, {@Named('baseUrl') String? baseUrl}) =
      _CartApiClient;

  @GET(ApiEndPoints.basket)
  Future<List<CartResponseDTO>> getBasket();

  @DELETE(ApiEndPoints.basket)
  Future<void> removeBasket();

  @DELETE("${ApiEndPoints.basket}/{companyId}/items/{productId}")
  Future<void> removeItem(@Path(ApiConstants.companyId) int companyId,
      @Path(ApiConstants.productId) int productId);

  @PUT("${ApiEndPoints.basket}/{companyId}/items/{productId}")
  Future<void> updateItemQuantity(
      @Path(ApiConstants.companyId) int companyId,
      @Path(ApiConstants.productId) int productId,
      @Query(ApiConstants.quantity) int quantity);
}
