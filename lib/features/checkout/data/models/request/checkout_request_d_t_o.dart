import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

part 'checkout_request_d_t_o.g.dart';

@JsonSerializable()
class CheckoutRequestDTO {
  @JsonKey(name: ApiConstants.basketId)
  final int? basketId;
  @JsonKey(name: ApiConstants.deliveryFee)
  final int? deliveryFee;
  @JsonKey(name: ApiConstants.address)
  final String? address;

  const CheckoutRequestDTO({
    required this.basketId,
    required this.deliveryFee,
    required this.address,
  });

  factory CheckoutRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutRequestDTOToJson(this);
}
