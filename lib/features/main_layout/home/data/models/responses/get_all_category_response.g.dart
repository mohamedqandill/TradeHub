// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCategoryResponse _$GetAllCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllCategoryResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$GetAllCategoryResponseToJson(
        GetAllCategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
