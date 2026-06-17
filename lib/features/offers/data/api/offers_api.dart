import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/authentication/data/models/login/login_request_body.dart';
import 'package:tradehub/features/authentication/data/models/login/login_response_dto.dart';
import 'package:tradehub/features/authentication/data/models/register/register_response.dart';
import 'package:tradehub/features/offers/data/models/add_offer_request_body.dart';
import 'package:tradehub/features/offers/data/models/offers_response.dart';

import '../../../../../core/api/api_endpoints/api_endpoints.dart';

part 'offers_api.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@injectable
@singleton
abstract class OffersApiClient {
  @factoryMethod
  factory OffersApiClient(Dio dio, {@Named("baseUrl") String? baseUrl}) =
      _OffersApiClient;

  @GET(ApiEndPoints.offers)
  Future<OffersResponse> getOffers();

    @GET("${ApiEndPoints.offers}/{id}")
  Future<OfferResponse> getOfferDetails(@Path("id") int id);

  @POST(ApiEndPoints.addOfferToCart)
  Future<void> addOfferToCart({
    @Body() required AddOfferRequestBody addOfferRequestBody,
  });

}
