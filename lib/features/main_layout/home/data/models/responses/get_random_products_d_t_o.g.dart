// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_random_products_d_t_o.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRandomProductsDTO _$GetRandomProductsDTOFromJson(
        Map<String, dynamic> json) =>
    GetRandomProductsDTO(
      isFavourite: json['isFavourite'] as bool?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      companyId: json['companyId'] as String?,
      companyName: json['companyName'] as String?,
      attributes: json['attributes'] as List<dynamic>?,
      averageRating: (json['averageRating'] as num?)?.toInt(),
      ratingCount: (json['ratingCount'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      logoUrl: json['logoUrl'] as String?,
    );

Map<String, dynamic> _$GetRandomProductsDTOToJson(
        GetRandomProductsDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'quantity': instance.quantity,
      'categoryId': instance.categoryId,
      'imageUrl': instance.imageUrl,
      'logoUrl': instance.logoUrl,
      'categoryName': instance.categoryName,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'attributes': instance.attributes,
      'averageRating': instance.averageRating,
      'ratingCount': instance.ratingCount,
      'isFavourite': instance.isFavourite,
    };
