import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/api/api_constant/api_constant.dart';

@JsonSerializable()
class GetCompanyEntity {
  @JsonKey(name: ApiConstants.id)
  final String? id;
  @JsonKey(name: ApiConstants.businessName)
  final String? businessName;
  @JsonKey(name: ApiConstants.businessTypeId)
  final int? businessTypeId;
  @JsonKey(name: ApiConstants.taxNumber)
  final String? taxNumber;
  @JsonKey(name: ApiConstants.logoUrl)
  final String? logoUrl;
  @JsonKey(name: ApiConstants.createdById)
  final String? createdById;
  @JsonKey(name: ApiConstants.locationId)
  final int? locationId;
  @JsonKey(name: ApiConstants.businessTypeName)
  final String? businessTypeName;
  @JsonKey(name: ApiConstants.locationName)
  final String? locationName;

  @JsonKey(name: ApiConstants.averageRating)
  final int? avgRating;

  @JsonKey(name: ApiConstants.ratingCount)
  final int? reviewCount;

  GetCompanyEntity({
    required this.id,
     this.avgRating,
     this.reviewCount,
    required this.businessName,
    required this.businessTypeId,
    required this.taxNumber,
    required this.logoUrl,
    required this.createdById,
    required this.locationId,
    required this.businessTypeName,
    required this.locationName,
  });
}
