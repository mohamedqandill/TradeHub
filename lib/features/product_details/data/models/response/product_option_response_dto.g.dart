// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_option_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOptionDTO _$ProductOptionDTOFromJson(Map<String, dynamic> json) =>
    ProductOptionDTO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      isRequired: json['isRequired'] as bool?,
      allowMultiple: json['allowMultiple'] as bool?,
      values: (json['values'] as List<dynamic>?)
          ?.map(
              (e) => ProductOptionValueDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductOptionDTOToJson(ProductOptionDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isRequired': instance.isRequired,
      'allowMultiple': instance.allowMultiple,
      'values': instance.values,
    };

ProductOptionValueDTO _$ProductOptionValueDTOFromJson(
        Map<String, dynamic> json) =>
    ProductOptionValueDTO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      extraPrice: (json['extraPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductOptionValueDTOToJson(
        ProductOptionValueDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'extraPrice': instance.extraPrice,
    };
