import 'package:json_annotation/json_annotation.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';

part 'payment_webhook_response_d_t_o.g.dart';

@JsonSerializable()
class PaymentWebhookRequest {
  @JsonKey(name: ApiConstants.obj)
  final WebhookObject? obj;

  const PaymentWebhookRequest({
    required this.obj,
  });

  factory PaymentWebhookRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentWebhookRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentWebhookRequestToJson(this);
}

@JsonSerializable()
class WebhookObject {
  @JsonKey(name: ApiConstants.id)
  final int? id;
  @JsonKey(name: ApiConstants.success)
  final bool? success;
  @JsonKey(name: ApiConstants.pending)
  final bool? pending;
  @JsonKey(name: ApiConstants.extras)
  final WebhookExtras? extras;
  @JsonKey(name: ApiConstants.order)
  final WebhookOrder? order;

  const WebhookObject({
    required this.id,
    required this.success,
    required this.pending,
    required this.extras,
    required this.order,
  });

  factory WebhookObject.fromJson(Map<String, dynamic> json) =>
      _$WebhookObjectFromJson(json);

  Map<String, dynamic> toJson() => _$WebhookObjectToJson(this);
}

@JsonSerializable()
class WebhookExtras {
  @JsonKey(name: ApiConstants.orderIdUnderscore)
  final int? orderId;

  const WebhookExtras({
    required this.orderId,
  });

  factory WebhookExtras.fromJson(Map<String, dynamic> json) =>
      _$WebhookExtrasFromJson(json);

  Map<String, dynamic> toJson() => _$WebhookExtrasToJson(this);
}

@JsonSerializable()
class WebhookOrder {
  @JsonKey(name: ApiConstants.id)
  final int? id;

  const WebhookOrder({
    required this.id,
  });

  factory WebhookOrder.fromJson(Map<String, dynamic> json) =>
      _$WebhookOrderFromJson(json);

  Map<String, dynamic> toJson() => _$WebhookOrderToJson(this);
}
