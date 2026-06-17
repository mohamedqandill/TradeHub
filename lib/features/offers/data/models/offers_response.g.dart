// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersResponse _$OffersResponseFromJson(Map<String, dynamic> json) =>
    OffersResponse(
      pageIndex: (json['pageIndex'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OfferResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OffersResponseToJson(OffersResponse instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'count': instance.count,
      'data': instance.data,
    };

OfferResponse _$OfferResponseFromJson(Map<String, dynamic> json) =>
    OfferResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      companyId: json['companyId'] as String?,
      companyName: json['companyName'] as String?,
      logoUrlCompany: json['logoUrlCompany'] as String?,
      offerType: json['offerType'] as String?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      originalTotalPrice: (json['originalTotalPrice'] as num?)?.toDouble(),
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      savedAmount: (json['savedAmount'] as num?)?.toDouble(),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      isActive: json['isActive'] as bool?,
      isCurrentlyActive: json['isCurrentlyActive'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              OfferProductItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfferResponseToJson(OfferResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'logoUrlCompany': instance.logoUrlCompany,
      'offerType': instance.offerType,
      'discountPercentage': instance.discountPercentage,
      'originalTotalPrice': instance.originalTotalPrice,
      'finalPrice': instance.finalPrice,
      'savedAmount': instance.savedAmount,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'isActive': instance.isActive,
      'isCurrentlyActive': instance.isCurrentlyActive,
      'items': instance.items,
    };

OfferProductItemResponse _$OfferProductItemResponseFromJson(
        Map<String, dynamic> json) =>
    OfferProductItemResponse(
      productId: (json['productId'] as num?)?.toInt(),
      productName: json['productName'] as String?,
      productImage: json['productImage'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toInt(),
      isGift: json['isGift'] as bool?,
    );

Map<String, dynamic> _$OfferProductItemResponseToJson(
        OfferProductItemResponse instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productImage': instance.productImage,
      'price': instance.price,
      'quantity': instance.quantity,
      'isGift': instance.isGift,
    };
