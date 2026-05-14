import 'package:json_annotation/json_annotation.dart';

part 'order_details_response_d_t_o.g.dart';

@JsonSerializable()
class OrderDetailsResponseDTO {
  final int id;
  final double subTotal;
  final double deliveryFee;
  final double total;
  final String orderStatus;
  final String paymentStatus;
  final String address;
  final String companyName;
  final String companyLogo;
  final String createdAt;
  final List<OrderItemDTO> items;
  final String? maskedCardNumber;

  OrderDetailsResponseDTO({
    required this.id,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
    required this.orderStatus,
    required this.paymentStatus,
    required this.address,
    required this.companyName,
    required this.companyLogo,
    required this.createdAt,
    required this.items,
    required this.maskedCardNumber,
  });

  factory OrderDetailsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsResponseDTOToJson(this);
}

@JsonSerializable()
class OrderItemDTO {
  final int productId;
  final String productName;
  final String imageUrl;
  final double price;
  final int quantity;

  OrderItemDTO({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory OrderItemDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDTOToJson(this);
}
