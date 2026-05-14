import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/shared_widgets/widgets/custom_error_widget.dart';
import 'package:tradehub/core/utils/animations/loading_product_animation.dart';
import 'package:tradehub/features/your_orders/presentation/cubit/orders_cubit.dart';

import 'order_card_widget.dart';

class YourOrdersScreenBody extends StatelessWidget {
  const YourOrdersScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is GetOrdersLoading) {
          return loadingProductAnimation();
        }

        if (state is GetOrdersError) {
          return CustomErrorWidget(
            message: state.error.message,
            onRetry: () => context.read<OrdersCubit>().getOrders(),
          );
        }

        if (state is GetOrdersSuccess) {
          final orders = state.orders;
          if (orders.isEmpty) {
            return const Center(child: Text("No orders found."));
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            itemCount: orders.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return OrderCardWidget(order: orders[index]);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
