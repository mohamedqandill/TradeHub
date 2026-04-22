import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/api/api_constant/api_constant.dart';

@JsonSerializable()
class GetCategoryEntity {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.name)
  final String? name;

  GetCategoryEntity({required this.id, required this.name});
}
