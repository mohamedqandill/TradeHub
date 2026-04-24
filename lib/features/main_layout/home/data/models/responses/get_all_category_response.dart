import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/features/main_layout/home/domain/entites/get_category_entity.dart';

import '../../../../../../core/api/api_constant/api_constant.dart';

part 'get_all_category_response.g.dart';

@JsonSerializable()
class GetAllCategoryResponse {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.name)
  final String? name;
  @JsonKey(name: ApiConstants.imageUrl)
  final String? imageUrl;

  const GetAllCategoryResponse({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory GetAllCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCategoryResponseToJson(this);

  toEntity() {
    return GetCategoryEntity(id: id ?? 0, name: name ?? "", imageUrl: imageUrl ?? "");
  }
}
