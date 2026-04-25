import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';

part 'product_ratings_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@singleton
@injectable
abstract class ProductRatingsApiClient {
  @factoryMethod
  factory ProductRatingsApiClient(Dio dio,
      {@Named('baseUrl') String? baseUrl}) = _ProductRatingsApiClient;

  @GET("${ApiEndPoints.productRatings}{productId}")
  Future<List<ProductRatingDTO>> getProductRatings(
    @Path("productId") int productId,
  );

  @POST("${ApiEndPoints.productRatings}{productId}")
  Future<ProductRatingDTO> addProductRating(
      @Path("productId") int productId, @Body() Map<String, dynamic> body);
}
