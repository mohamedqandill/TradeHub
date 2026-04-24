class VendorDetailsEntity {
  final String id;
  final String businessName;
  final int businessTypeId;
  final String taxNumber;
  final String logoUrl;
  final String createdById;
  final int locationId;
  final String businessTypeName;
  final String locationName;

  VendorDetailsEntity({
    required this.id,
    required this.businessName,
    required this.businessTypeId,
    required this.taxNumber,
    required this.logoUrl,
    required this.createdById,
    required this.locationId,
    required this.businessTypeName,
    required this.locationName,
  });
}

class VendorSubcategoryEntity {
  final int id;
  final String name;
  final bool isActive;

  VendorSubcategoryEntity({
    required this.id,
    required this.name,
    required this.isActive,
  });
}

class VendorProductEntity {
  final int id;
  final String name;
  final String description;
  final int price;
  final int quantity;
  final String categoryName;
  final List<VendorProductAttributeEntity> attributes;
  final int averageRating;
  final int ratingCount;
  final bool isFavourite;

  VendorProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.categoryName,
    required this.attributes,
    required this.averageRating,
    required this.ratingCount,
    required this.isFavourite,
  });
}

class VendorProductAttributeEntity {
  final int id;
  final String name;
  final String value;

  VendorProductAttributeEntity({
    required this.id,
    required this.name,
    required this.value,
  });
}
