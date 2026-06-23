// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_companies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCompanies _$GetCompaniesFromJson(Map<String, dynamic> json) => GetCompanies(
      pageIndex: (json['pageIndex'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => CompanyData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCompaniesToJson(GetCompanies instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'count': instance.count,
      'data': instance.data,
    };

CompanyData _$CompanyDataFromJson(Map<String, dynamic> json) => CompanyData(
      id: json['id'] as String?,
      ratingCount: (json['ratingCount'] as num?)?.toInt(),
      averageRating: (json['averageRating'] as num?)?.toInt(),
      businessName: json['businessName'] as String?,
      businessTypeId: (json['businessTypeId'] as num?)?.toInt(),
      taxNumber: json['taxNumber'] as String?,
      logoUrl: json['logoUrl'] as String?,
      createdById: json['createdById'] as String?,
      locationId: (json['locationId'] as num?)?.toInt(),
      businessTypeName: json['businessTypeName'] as String?,
      locationName: json['locationName'] as String?,
    );

Map<String, dynamic> _$CompanyDataToJson(CompanyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessName': instance.businessName,
      'businessTypeId': instance.businessTypeId,
      'taxNumber': instance.taxNumber,
      'logoUrl': instance.logoUrl,
      'createdById': instance.createdById,
      'locationId': instance.locationId,
      'businessTypeName': instance.businessTypeName,
      'locationName': instance.locationName,
      'ratingCount': instance.ratingCount,
      'averageRating': instance.averageRating,
    };
