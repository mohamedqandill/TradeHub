import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_company_entity.dart';

import '../../../../../../core/api/api_constant/api_constant.dart';

part 'get_companies.g.dart';

@JsonSerializable()
class GetCompanies {
  @JsonKey(name: ApiConstants.pageIndex)
  final int pageIndex;
  @JsonKey(name: ApiConstants.pageSize)
  final int pageSize;
  @JsonKey(name: ApiConstants.count)
  final int count;
  @JsonKey(name: ApiConstants.data)
  final List<CompanyData> data;

  const GetCompanies({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.data,
  });

  factory GetCompanies.fromJson(Map<String, dynamic> json) =>
      _$GetCompaniesFromJson(json);

  Map<String, dynamic> toJson() => _$GetCompaniesToJson(this);
}

@JsonSerializable()
class CompanyData {
  @JsonKey(name: ApiConstants.id)
  final String id;
  @JsonKey(name: ApiConstants.businessName)
  final String businessName;
  @JsonKey(name: ApiConstants.businessTypeId)
  final int businessTypeId;
  @JsonKey(name: ApiConstants.taxNumber)
  final String taxNumber;
  @JsonKey(name: ApiConstants.logoUrl)
  final String logoUrl;
  @JsonKey(name: ApiConstants.createdById)
  final String createdById;
  @JsonKey(name: ApiConstants.locationId)
  final int locationId;
  @JsonKey(name: ApiConstants.businessTypeName)
  final String businessTypeName;
  @JsonKey(name: ApiConstants.locationName)
  final String locationName;

  const CompanyData({
    required this.id,
    required this.businessName,
    required this.businessTypeId,
    required this.taxNumber,
    required this.logoUrl,
    required this.createdById,
    required this.locationId,
    required this.businessTypeName,
    required this.locationName,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) =>
      _$CompanyDataFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDataToJson(this);

  toEntity() {
    return GetCompanyEntity(
      id: id,
      businessName: businessName,
      businessTypeId: businessTypeId,
      taxNumber: taxNumber,
      logoUrl: logoUrl,
      createdById: createdById,
      locationId: locationId,
      businessTypeName: businessTypeName,
      locationName: locationName,
    );
  }
}
