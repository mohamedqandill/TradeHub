// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_favorite_products_response_d_t_o.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFavoriteProductsResponseDTO _$GetFavoriteProductsResponseDTOFromJson(
        Map<String, dynamic> json) =>
    GetFavoriteProductsResponseDTO(
      pageIndex: (json['pageIndex'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FavoriteProductDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetFavoriteProductsResponseDTOToJson(
        GetFavoriteProductsResponseDTO instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'count': instance.count,
      'data': instance.data,
    };

FavoriteProductDTO _$FavoriteProductDTOFromJson(Map<String, dynamic> json) =>
    FavoriteProductDTO(
      imageUrl: json['imageUrl'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
      companyId: json['companyId'] as String?,
      companyName: json['companyName'] as String?,
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map(
              (e) => FavoriteAttributesDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      ratingCount: (json['ratingCount'] as num?)?.toInt(),
      isFavourite: json['isFavourite'] as bool?,
    );

Map<String, dynamic> _$FavoriteProductDTOToJson(FavoriteProductDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'quantity': instance.quantity,
      'categoryId': instance.categoryId,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'attributes': instance.attributes,
      'averageRating': instance.averageRating,
      'ratingCount': instance.ratingCount,
      'isFavourite': instance.isFavourite,
      'imageUrl': instance.imageUrl,
    };

FavoriteAttributesDTO _$FavoriteAttributesDTOFromJson(
        Map<String, dynamic> json) =>
    FavoriteAttributesDTO(
      id: (json['id'] as num?)?.toInt(),
      categoryAttributeId: (json['categoryAttributeId'] as num?)?.toInt(),
      categoryAttributeName: json['categoryAttributeName'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$FavoriteAttributesDTOToJson(
        FavoriteAttributesDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryAttributeId': instance.categoryAttributeId,
      'categoryAttributeName': instance.categoryAttributeName,
      'value': instance.value,
    };
