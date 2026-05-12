import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';

class OrderDetailsArgs {
  final int orderId;
  final List<Items> items;
  final String address;
  final String status;
  final int subTotal;

  OrderDetailsArgs({
    required this.orderId,
    required this.items,
    required this.address,
    required this.status,
    required this.subTotal,
  });
}
