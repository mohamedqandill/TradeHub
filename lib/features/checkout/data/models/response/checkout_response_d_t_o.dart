import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

part 'checkout_response_d_t_o.g.dart';

@JsonSerializable()
class CheckoutResponseDTO {
  @JsonKey(name: ApiConstants.orderId)
  final int? orderId;
  @JsonKey(name: ApiConstants.clientSecret)
  final String? clientSecret;
  @JsonKey(name: ApiConstants.paymentIntentId)
  final String? paymentIntentId;
  @JsonKey(name: ApiConstants.publicKey)
  final String? publicKey;
  @JsonKey(name: ApiConstants.paymentUrl)
  final String? paymentUrl;

  const CheckoutResponseDTO({
    required this.orderId,
    required this.clientSecret,
    required this.paymentIntentId,
    required this.publicKey,
    required this.paymentUrl,
  });

  factory CheckoutResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutResponseDTOToJson(this);
}
