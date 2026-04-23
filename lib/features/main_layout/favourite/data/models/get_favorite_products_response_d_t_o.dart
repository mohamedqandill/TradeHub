import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/features/main_layout/favourite/domain/entites/favourite_product_entity.dart';
import '../../../../../core/api/api_constant/api_constant.dart';

part 'get_favorite_products_response_d_t_o.g.dart';

@JsonSerializable()
class GetFavoriteProductsResponseDTO {
  @JsonKey(name: ApiConstants.pageIndex)
  final int? pageIndex;
  @JsonKey(name: ApiConstants.pageSize)
  final int? pageSize;
  @JsonKey(name: ApiConstants.count)
  final int? count;
  @JsonKey(name: ApiConstants.data)
  final List<FavoriteProductDTO>? data;

  const GetFavoriteProductsResponseDTO({
    this.pageIndex,
    this.pageSize,
    this.count,
    this.data,
  });

  factory GetFavoriteProductsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$GetFavoriteProductsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetFavoriteProductsResponseDTOToJson(this);
}

@JsonSerializable()
class FavoriteProductDTO {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.name)
  final String? name;
  @JsonKey(name: ApiConstants.description)
  final String? description;
  @JsonKey(name: ApiConstants.price)
  final double? price;
  @JsonKey(name: ApiConstants.quantity)
  final int? quantity;
  @JsonKey(name: ApiConstants.categoryId)
  final int? categoryId;
  @JsonKey(name: ApiConstants.companyId)
  final String? companyId;
  @JsonKey(name: ApiConstants.companyName)
  final String? companyName;
  @JsonKey(name: ApiConstants.attributes)
  final List<FavoriteAttributesDTO>? attributes;
  @JsonKey(name: ApiConstants.averageRating)
  final double? averageRating;
  @JsonKey(name: ApiConstants.ratingCount)
  final int? ratingCount;
  @JsonKey(name: ApiConstants.isFavourite)
  final bool? isFavourite;

  const FavoriteProductDTO({
    this.id,
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.categoryId,
    this.companyId,
    this.companyName,
    this.attributes,
    this.averageRating,
    this.ratingCount,
    this.isFavourite,
  });

  factory FavoriteProductDTO.fromJson(Map<String, dynamic> json) =>
      _$FavoriteProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteProductDTOToJson(this);

  FavoriteProductEntity toEntity() {
    return FavoriteProductEntity(
      id: id ?? 0,
      name: name ?? '',
      description: description ?? '',
      price: price ?? 0.0,
      quantity: quantity ?? 0,
      categoryId: categoryId ?? 0,
      companyId: companyId ?? '',
      companyName: companyName ?? '',
      attributes: attributes?.map((e) => e.toEntity()).toList() ?? [],
      averageRating: averageRating ?? 0.0,
      ratingCount: ratingCount ?? 0,
      isFavourite: isFavourite ?? false,
    );
  }
}

@JsonSerializable()
class FavoriteAttributesDTO {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.categoryAttributeId)
  final int? categoryAttributeId;
  @JsonKey(name: ApiConstants.categoryAttributeName)
  final String? categoryAttributeName;
  @JsonKey(name: ApiConstants.value)
  final String? value;

  const FavoriteAttributesDTO({
    this.id,
    this.categoryAttributeId,
    this.categoryAttributeName,
    this.value,
  });

  factory FavoriteAttributesDTO.fromJson(Map<String, dynamic> json) =>
      _$FavoriteAttributesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteAttributesDTOToJson(this);

  FavoriteAttributesEntity toEntity() {
    return FavoriteAttributesEntity(
      id: id ?? 0,
      categoryAttributeId: categoryAttributeId ?? 0,
      categoryAttributeName: categoryAttributeName ?? '',
      value: value ?? '',
    );
  }
}
