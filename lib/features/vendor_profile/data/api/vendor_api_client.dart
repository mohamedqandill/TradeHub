import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tradehub/core/api/api_endpoints/api_endpoints.dart';
import 'package:tradehub/features/product_ratings/data/models/product_rating_d_t_o.dart';
import 'package:tradehub/features/vendor_profile/data/models/vendor_models.dart';

part 'vendor_api_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseURL)
@injectable
abstract class VendorApiClient {
  @factoryMethod
  factory VendorApiClient(Dio dio,{@Named("baseUrl") String? baseUrl}) = _VendorApiClient;

  @GET("${ApiEndPoints.companyDetails}{id}")
  Future<VendorDetailsModel> getCompanyDetails(@Path("id") String id);

  @GET("${ApiEndPoints.companySubcategories}{id}/subcategories")
  Future<List<VendorSubcategoryModel>> getCompanySubcategories(@Path("id") String id);

  @GET("${ApiEndPoints.productsBySubcategory}{id}")
  Future<List<VendorProductModel>> getProductsBySubcategory(@Path("id") int id);

  @GET("api/CompanyRatings/{companyId}/ratings")
  Future<List<ProductRatingDTO>> getCompanyRatings(
    @Path("companyId") String companyId,
  );

  @POST("api/CompanyRatings/{companyId}/ratings")
  Future<ProductRatingDTO> addCompanyRating(
    @Path("companyId") String companyId,
    @Body() Map<String, dynamic> body,
  );
}
