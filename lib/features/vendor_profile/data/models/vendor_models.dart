import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/features/vendor_profile/domain/entities/vendor_entities.dart';

part 'vendor_models.g.dart';

@JsonSerializable()
class VendorDetailsModel {
  @JsonKey(name: ApiConstants.id)
  final String? id;
  @JsonKey(name: ApiConstants.businessName)
  final String? businessName;
  @JsonKey(name: ApiConstants.businessTypeId)
  final int? businessTypeId;
  @JsonKey(name: ApiConstants.taxNumber)
  final String? taxNumber;
  @JsonKey(name: ApiConstants.logoUrl)
  final String? logoUrl;
  @JsonKey(name: ApiConstants.createdById)
  final String? createdById;
  @JsonKey(name: ApiConstants.locationId)
  final int? locationId;
  @JsonKey(name: ApiConstants.businessTypeName)
  final String? businessTypeName;
  @JsonKey(name: ApiConstants.locationName)
  final String? locationName;


    @JsonKey(name: ApiConstants.averageRating)
  final int? avgRating;

  @JsonKey(name: ApiConstants.ratingCount)
  final int? reviewCount;

  VendorDetailsModel({
    this.id,
    this.businessName,
    this.businessTypeId,
    this.taxNumber,
      this.avgRating,
  this.reviewCount,
    this.logoUrl,
    this.createdById,
    this.locationId,
    this.businessTypeName,
    this.locationName,
  });

  factory VendorDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$VendorDetailsModelFromJson(json);

  VendorDetailsEntity toEntity() => VendorDetailsEntity(
        id: id ?? "",
        businessName: businessName ?? "",
        businessTypeId: businessTypeId ?? 0,
        taxNumber: taxNumber ?? "",
        logoUrl: logoUrl ?? "",
        createdById: createdById ?? "",
        locationId: locationId ?? 0,
        businessTypeName: businessTypeName ?? "",
        locationName: locationName ?? "",
           avgRating: avgRating,
  reviewCount: reviewCount,
      );
}

@JsonSerializable()
class VendorSubcategoryModel {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.name)
  final String? name;
  @JsonKey(name: ApiConstants.isActive)
  final bool? isActive;

  VendorSubcategoryModel({
    this.id,
    this.name,
    this.isActive,
  });

  factory VendorSubcategoryModel.fromJson(Map<String, dynamic> json) =>
      _$VendorSubcategoryModelFromJson(json);

  VendorSubcategoryEntity toEntity() => VendorSubcategoryEntity(
        id: id ?? 0,
        name: name ?? "",
        isActive: isActive ?? false,
      );
}

@JsonSerializable()
class VendorProductModel {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.name)
  final String? name;
  @JsonKey(name: ApiConstants.description)
  final String? description;
  @JsonKey(name: ApiConstants.price)
  final int? price;
  @JsonKey(name: ApiConstants.quantity)
  final int? quantity;
  @JsonKey(name: ApiConstants.categoryName)
  final String? categoryName;
  @JsonKey(name: ApiConstants.attributes)
  final List<VendorProductAttributeModel>? attributes;
  @JsonKey(name: ApiConstants.averageRating)
  final int? averageRating;
  @JsonKey(name: ApiConstants.ratingCount)
  final int? ratingCount;
  @JsonKey(name: ApiConstants.isFavourite)
  final bool? isFavourite;
  @JsonKey(name: ApiConstants.imageUrl)
  final String? imageUrl;
  @JsonKey(name: ApiConstants.hasOffer)
  final bool? hasOffer;
  @JsonKey(name: ApiConstants.isOfferActive)
  final bool? isOfferActive;
  @JsonKey(name: ApiConstants.discountPercentage)
  final int? discountPercentage;
  @JsonKey(name: ApiConstants.offerStartDate)
  final String? offerStartDate;
  @JsonKey(name: ApiConstants.offerEndDate)
  final String? offerEndDate;
  @JsonKey(name: ApiConstants.finalPrice)
  final int? finalPrice;


  VendorProductModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.quantity,
      this.categoryName,
      this.attributes,
      this.averageRating,
      this.ratingCount,
      this.isFavourite,
      this.imageUrl,
      this.hasOffer,
      this.isOfferActive,
      this.discountPercentage,
      this.offerStartDate,
      this.offerEndDate,
      this.finalPrice});

  factory VendorProductModel.fromJson(Map<String, dynamic> json) =>
      _$VendorProductModelFromJson(json);

  VendorProductEntity toEntity() => VendorProductEntity(
        imageUrl: imageUrl ?? "",
        id: id ?? 0,
        name: name ?? "",
        description: description ?? "",
        price: price ?? 0,
        quantity: quantity ?? 0,
        categoryName: categoryName ?? "",
        attributes: attributes?.map((e) => e.toEntity()).toList() ?? [],
        averageRating: averageRating ?? 0,
        ratingCount: ratingCount ?? 0,
        isFavourite: isFavourite ?? false,
        hasOffer: hasOffer ?? false,
        isOfferActive: isOfferActive ?? false,
        discountPercentage: discountPercentage ?? 0,
        offerStartDate: offerStartDate ?? "",
        offerEndDate: offerEndDate ?? "",
        finalPrice: finalPrice ?? 0,
      );
}

@JsonSerializable()
class VendorProductAttributeModel {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.categoryAttributeName)
  final String? name;
  @JsonKey(name: ApiConstants.value)
  final String? value;

  VendorProductAttributeModel({
    this.id,
    this.name,
    this.value,
  });

  factory VendorProductAttributeModel.fromJson(Map<String, dynamic> json) =>
      _$VendorProductAttributeModelFromJson(json);

  VendorProductAttributeEntity toEntity() => VendorProductAttributeEntity(
        id: id ?? 0,
        name: name ?? "",
        value: value ?? "",
      );
}
