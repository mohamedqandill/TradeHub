// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorDetailsModel _$VendorDetailsModelFromJson(Map<String, dynamic> json) =>
    VendorDetailsModel(
      id: json['id'] as String?,
      businessName: json['businessName'] as String?,
      businessTypeId: (json['businessTypeId'] as num?)?.toInt(),
      taxNumber: json['taxNumber'] as String?,
      avgRating: (json['averageRating'] as num?)?.toInt(),
      reviewCount: (json['ratingCount'] as num?)?.toInt(),
      logoUrl: json['logoUrl'] as String?,
      createdById: json['createdById'] as String?,
      locationId: (json['locationId'] as num?)?.toInt(),
      businessTypeName: json['businessTypeName'] as String?,
      locationName: json['locationName'] as String?,
    );

Map<String, dynamic> _$VendorDetailsModelToJson(VendorDetailsModel instance) =>
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
      'averageRating': instance.avgRating,
      'ratingCount': instance.reviewCount,
    };

VendorSubcategoryModel _$VendorSubcategoryModelFromJson(
        Map<String, dynamic> json) =>
    VendorSubcategoryModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$VendorSubcategoryModelToJson(
        VendorSubcategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isActive': instance.isActive,
    };

VendorProductModel _$VendorProductModelFromJson(Map<String, dynamic> json) =>
    VendorProductModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) =>
              VendorProductAttributeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageRating: (json['averageRating'] as num?)?.toInt(),
      ratingCount: (json['ratingCount'] as num?)?.toInt(),
      isFavourite: json['isFavourite'] as bool?,
      imageUrl: json['imageUrl'] as String?,
      hasOffer: json['hasOffer'] as bool?,
      isOfferActive: json['isOfferActive'] as bool?,
      discountPercentage: (json['discountPercentage'] as num?)?.toInt(),
      offerStartDate: json['offerStartDate'] as String?,
      offerEndDate: json['offerEndDate'] as String?,
      finalPrice: (json['finalPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VendorProductModelToJson(VendorProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'quantity': instance.quantity,
      'categoryName': instance.categoryName,
      'attributes': instance.attributes,
      'averageRating': instance.averageRating,
      'ratingCount': instance.ratingCount,
      'isFavourite': instance.isFavourite,
      'imageUrl': instance.imageUrl,
      'hasOffer': instance.hasOffer,
      'isOfferActive': instance.isOfferActive,
      'discountPercentage': instance.discountPercentage,
      'offerStartDate': instance.offerStartDate,
      'offerEndDate': instance.offerEndDate,
      'finalPrice': instance.finalPrice,
    };

VendorProductAttributeModel _$VendorProductAttributeModelFromJson(
        Map<String, dynamic> json) =>
    VendorProductAttributeModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['categoryAttributeName'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$VendorProductAttributeModelToJson(
        VendorProductAttributeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryAttributeName': instance.name,
      'value': instance.value,
    };
