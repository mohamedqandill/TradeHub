import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../../core/api/api_endpoints/api_endpoints.dart';
import '../models/get_favorite_products_response_d_t_o.dart';

part 'favourite_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@singleton
@injectable
abstract class FavouriteApiClient {
  @factoryMethod
  factory FavouriteApiClient(Dio dio, {@Named('baseUrl') String? baseUrl}) =
      _FavouriteApiClient;

  @GET(ApiEndPoints.getFavorites)
  Future<GetFavoriteProductsResponseDTO> getFavorites();

  @POST("${ApiEndPoints.toggleFavorite}{id}")
  Future<void> toggleFavorite(@Path("id") int id);
}
