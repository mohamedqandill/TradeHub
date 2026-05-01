// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_company_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryCompanyDTO _$CategoryCompanyDTOFromJson(Map<String, dynamic> json) =>
    CategoryCompanyDTO(
      companyName: json['companyName'] as String?,
      companyId: json['companyId'] as String?,
      categoryName: json['categoryName'] as String?,
      locationName: json['locationName'] as String?,
      businessTypeName: json['businessTypeName'] as String?,
      logoUrl: json['logoUrl'] as String?,
      taxNumber: json['taxNumber'] as String?,
    );

Map<String, dynamic> _$CategoryCompanyDTOToJson(CategoryCompanyDTO instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'categoryName': instance.categoryName,
      'locationName': instance.locationName,
      'businessTypeName': instance.businessTypeName,
      'logoUrl': instance.logoUrl,
      'taxNumber': instance.taxNumber,
      'companyId': instance.companyId,
    };
