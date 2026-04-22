import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';

import '../../../../../core/api/api_endpoints/api_endpoints.dart';
import '../models/response/product_details_response_d_t_o.dart';

part 'product_details_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@singleton
@injectable
abstract class ProductDetailsApiClient {
  @factoryMethod
  factory ProductDetailsApiClient(Dio dio, {@Named('baseUrl') String? baseUrl}) =
      _ProductDetailsApiClient;

  @GET("${ApiEndPoints.productDetails}{id}")
  Future<ProductDetailsResponseDTO> getProductDetails(@Path("id") int id);

  @POST(ApiEndPoints.addToCart)
  Future<CartResponseDTO> addToCart(@Body() Map<String, dynamic> body);

  @POST("${ApiEndPoints.toggleFavorite}{id}")
  Future<void> toggleFavorite(@Path("id") int id);
}
