import 'package:json_annotation/json_annotation.dart';
import 'get_random_products_d_t_o.dart';
import '../../../../../../core/api/api_constant/api_constant.dart';

part 'get_random_products_response.g.dart';

@JsonSerializable()
class GetRandomProductsResponse {
  @JsonKey(name: ApiConstants.pageIndex)
  final int pageIndex;
  @JsonKey(name: ApiConstants.pageSize)
  final int pageSize;
  @JsonKey(name: ApiConstants.count)
  final int count;
  @JsonKey(name: ApiConstants.data)
  final List<GetRandomProductsDTO> data;

  const GetRandomProductsResponse({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.data,
  });

  factory GetRandomProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetRandomProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetRandomProductsResponseToJson(this);
}
