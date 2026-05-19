// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_random_products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRandomProductsResponse _$GetRandomProductsResponseFromJson(
        Map<String, dynamic> json) =>
    GetRandomProductsResponse(
      pageIndex: (json['pageIndex'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => GetRandomProductsDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetRandomProductsResponseToJson(
        GetRandomProductsResponse instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'count': instance.count,
      'data': instance.data,
    };
