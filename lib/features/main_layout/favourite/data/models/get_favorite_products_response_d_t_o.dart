import 'package:json_annotation/json_annotation.dart';

part 'get_favorite_products_response_d_t_o.g.dart';

@JsonSerializable()
class GetFavoriteProductsResponseDTO {
  @JsonKey(defaultValue: 0)
  final int pageIndex;
  @JsonKey(defaultValue: 0)
  final int pageSize;
  @JsonKey(defaultValue: 0)
  final int count;
  @JsonKey(defaultValue: [])
  final List<Data> data;

  const GetFavoriteProductsResponseDTO({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.data,
  });

  factory GetFavoriteProductsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$GetFavoriteProductsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetFavoriteProductsResponseDTOToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String name;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(defaultValue: 0)
  final int price;
  @JsonKey(defaultValue: 0)
  final int quantity;
  @JsonKey(defaultValue: 0)
  final int categoryId;
  @JsonKey(defaultValue: '')
  final String companyId;
  @JsonKey(defaultValue: '')
  final String companyName;
  @JsonKey(defaultValue: [])
  final List<Attributes> attributes;
  @JsonKey(defaultValue: 0)
  final int averageRating;
  @JsonKey(defaultValue: 0)
  final int ratingCount;
  @JsonKey(defaultValue: false)
  final bool isFavourite;

  const Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Attributes {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: 0)
  final int categoryAttributeId;
  @JsonKey(defaultValue: '')
  final String categoryAttributeName;
  @JsonKey(defaultValue: '')
  final String value;

  const Attributes({
    required this.id,
    required this.categoryAttributeId,
    required this.categoryAttributeName,
    required this.value,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
