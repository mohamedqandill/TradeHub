import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/features/category_details/domain/entities/category_company_entity.dart';

part 'category_company_dto.g.dart';

@JsonSerializable()
class CategoryCompanyDTO {
  @JsonKey(name: ApiConstants.companyName)
  final String? companyName;
  @JsonKey(name: ApiConstants.categoryName)
  final String? categoryName;
  @JsonKey(name: ApiConstants.locationName)
  final String? locationName;
  @JsonKey(name: ApiConstants.businessTypeName)
  final String? businessTypeName;
  @JsonKey(name: ApiConstants.logoUrl)
  final String? logoUrl;

  @JsonKey(name: ApiConstants.taxNumber)
  final String? taxNumber;
  @JsonKey(name: ApiConstants.companyId)
  final String? companyId;
  const CategoryCompanyDTO({
    required this.companyName,
    required this.companyId,
    required this.categoryName,
    required this.locationName,
    required this.businessTypeName,
    required this.logoUrl,
    required this.taxNumber,
  });

  factory CategoryCompanyDTO.fromJson(Map<String, dynamic> json) =>
      _$CategoryCompanyDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryCompanyDTOToJson(this);

  CategoryCompanyEntity toEntity() => CategoryCompanyEntity(
        companyId: companyId ?? "",
        companyName: companyName ?? "",
        categoryName: categoryName ?? "",
        locationName: locationName ?? "",
        businessTypeName: businessTypeName ?? "",
        logoUrl: logoUrl ?? "",
        taxNumber: taxNumber ?? "",
      );
}
