// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response_d_t_o.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponseDTO _$CartResponseDTOFromJson(Map<String, dynamic> json) =>
    CartResponseDTO(
      id: (json['id'] as num?)?.toInt(),
      buyerId: json['buyerId'] as String?,
      companyName: json['companyName'] as String?,
      companyId: json['companyId'] as String?,
      items: (json['basketItems'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      subTotal: (json['subTotal'] as num?)?.toInt() ?? 0,
      logoUrl: json['logoUrl'] as String?,
    );

Map<String, dynamic> _$CartResponseDTOToJson(CartResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buyerId': instance.buyerId,
      'companyName': instance.companyName,
      'companyId': instance.companyId,
      'basketItems': instance.items,
      'logoUrl': instance.logoUrl,
      'subTotal': instance.subTotal,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      productName: json['productName'] as String?,
      pictureUrl: json['pictureUrl'] as String?,
      price: (json['price'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => CartOptionDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      offerBundle: json['bundleOffer'] == null
          ? null
          : OfferResponse.fromJson(json['bundleOffer'] as Map<String, dynamic>),
      bundleOfferId: (json['bundleOfferId'] as num?)?.toInt(),
      isBundleOffer: json['isBundleOffer'] as bool?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'pictureUrl': instance.pictureUrl,
      'price': instance.price,
      'quantity': instance.quantity,
      'total': instance.total,
      'options': instance.options,
      'bundleOfferId': instance.bundleOfferId,
      'isBundleOffer': instance.isBundleOffer,
      'bundleOffer': instance.offerBundle,
    };

CartOptionDTO _$CartOptionDTOFromJson(Map<String, dynamic> json) =>
    CartOptionDTO(
      productOptionValueId: (json['productOptionValueId'] as num?)?.toInt(),
      optionName: json['optionName'] as String?,
      valueName: json['valueName'] as String?,
      extraPrice: (json['extraPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartOptionDTOToJson(CartOptionDTO instance) =>
    <String, dynamic>{
      'productOptionValueId': instance.productOptionValueId,
      'optionName': instance.optionName,
      'valueName': instance.valueName,
      'extraPrice': instance.extraPrice,
    };
