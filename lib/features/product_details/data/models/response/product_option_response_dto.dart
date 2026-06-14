import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

part 'product_option_response_dto.g.dart';

@JsonSerializable()
class ProductOptionDTO {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.name)
  final String? name;
  @JsonKey(name: ApiConstants.isRequired)
  final bool? isRequired;
  @JsonKey(name: ApiConstants.allowMultiple)
  final bool? allowMultiple;
  @JsonKey(name: ApiConstants.values)
  final List<ProductOptionValueDTO>? values;

  const ProductOptionDTO({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.allowMultiple,
    required this.values,
  });

  factory ProductOptionDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOptionDTOToJson(this);
}

@JsonSerializable()
class ProductOptionValueDTO {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.name)
  final String? name;
  @JsonKey(name: ApiConstants.extraPrice)
  final int? extraPrice;

  const ProductOptionValueDTO({
    required this.id,
    required this.name,
    required this.extraPrice,
  });

  factory ProductOptionValueDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionValueDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOptionValueDTOToJson(this);
}
