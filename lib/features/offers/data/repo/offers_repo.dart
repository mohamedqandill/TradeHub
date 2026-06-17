import 'package:injectable/injectable.dart';
import 'package:tradehub/core/api/api_executor/api_executor.dart';
import 'package:tradehub/core/api/api_result/api_result.dart';
import 'package:tradehub/features/offers/data/api/offers_api.dart';
import 'package:tradehub/features/offers/data/models/add_offer_request_body.dart';
import 'package:tradehub/features/offers/data/models/offers_response.dart';

abstract class OffersRepo {
  Future<ApiResult<OffersResponse>> getOffers();
  Future<ApiResult<OfferResponse>> getOfferDetails(int id);
  Future<ApiResult<void>> addOfferToCart({required AddOfferRequestBody addOfferRequestBody});
}

@Injectable(as: OffersRepo)
class OffersRepoImpl implements OffersRepo {
  final OffersApiClient _offersApiClient;
  OffersRepoImpl(this._offersApiClient);
  @override
  Future<ApiResult<OffersResponse>> getOffers() {
    return ApiExecutor.executeApi(
      apiCall: () => _offersApiClient.getOffers(),
    );
  }
  
  @override
  Future<ApiResult<OfferResponse>> getOfferDetails(int id) {
    return ApiExecutor.executeApi(
      apiCall: () => _offersApiClient.getOfferDetails(id),
    );
  }

  @override
  Future<ApiResult<void>> addOfferToCart({required AddOfferRequestBody addOfferRequestBody}) {
    return ApiExecutor.executeApi(
      apiCall: () => _offersApiClient.addOfferToCart(addOfferRequestBody: addOfferRequestBody),
    );
  }
}

