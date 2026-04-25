// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_response_d_t_o.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsResponseDTO _$ProductDetailsResponseDTOFromJson(
        Map<String, dynamic> json) =>
    ProductDetailsResponseDTO(
      imageUrl: json['imageUrl'] as String?,
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
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => Attributes.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageRating: (json['averageRating'] as num?)?.toInt(),
      ratingCount: (json['ratingCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductDetailsResponseDTOToJson(
        ProductDetailsResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'quantity': instance.quantity,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'attributes': instance.attributes,
      'averageRating': instance.averageRating,
      'ratingCount': instance.ratingCount,
      'isFavourite': instance.isFavourite,
      'imageUrl': instance.imageUrl,
    };

Attributes _$AttributesFromJson(Map<String, dynamic> json) => Attributes(
      id: (json['id'] as num?)?.toInt(),
      categoryAttributeId: (json['categoryAttributeId'] as num?)?.toInt(),
      categoryAttributeName: json['categoryAttributeName'] as String?,
      value: json['value'] as String? ?? '',
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryAttributeId': instance.categoryAttributeId,
      'categoryAttributeName': instance.categoryAttributeName,
      'value': instance.value,
    };
