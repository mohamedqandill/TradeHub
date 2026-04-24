class FavoriteProductEntity {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final int categoryId;
  final String companyId;
  final String companyName;
  final List<FavoriteAttributesEntity> attributes;
  final double averageRating;
  final int ratingCount;
  final bool isFavourite;

  FavoriteProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.categoryId,
    required this.companyId,
    required this.companyName,
    required this.attributes,
    required this.averageRating,
    required this.ratingCount,
    required this.isFavourite,
  });
}

class FavoriteAttributesEntity {
  final int id;
  final int categoryAttributeId;
  final String categoryAttributeName;
  final String value;

  FavoriteAttributesEntity({
    required this.id,
    required this.categoryAttributeId,
    required this.categoryAttributeName,
    required this.value,
  });
}
