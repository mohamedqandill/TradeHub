import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/shared_widgets/widgets/custom_error_widget.dart';
import 'package:tradehub/core/utils/animations/loading_product_animation.dart';
import 'package:tradehub/features/your_orders/presentation/cubit/orders_cubit.dart';
import 'package:tradehub/features/your_orders/presentation/widgets/orders_empty_state.dart';
import 'package:tradehub/main.dart';

import 'order_card_widget.dart';

class YourOrdersScreenBody extends StatefulWidget {
  const YourOrdersScreenBody({super.key});

  @override
  State<YourOrdersScreenBody> createState() => _YourOrdersScreenBodyState();
}

class _YourOrdersScreenBodyState extends State<YourOrdersScreenBody> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll * 0.9) {
      context.read<OrdersCubit>().getOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final isInitialLoading =
            state.requestState == RequestStates.loading &&
                state.orders.isEmpty &&
                !state.isFetchingMore;

        return _buildContent(context, state, isInitialLoading);
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    OrdersState state,
    bool isInitialLoading,
  ) {
    if (isInitialLoading) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: loadingProductAnimation(),
            ),
          );
        },
      );
    }

    if (state.requestState == RequestStates.error && state.orders.isEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: CustomErrorWidget(
                message: state.errorMessage ?? 'Failed to load orders.',
                onRetry: () =>
                    context.read<OrdersCubit>().getOrders(isRefresh: true),
              ),
            ),
          );
        },
      );
    }

    if (state.orders.isEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: OrdersEmptyState(status: state.selectedStatus),
            ),
          );
        },
      );
    }

    return ListView.separated(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
      itemCount: state.orders.length + (state.isFetchingMore ? 1 : 0),
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        if (index >= state.orders.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Center(
              child: SizedBox(
                width: 24.w,
                height: 24.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: context.mainColor,
                ),
              ),
            ),
          );
        }

        return OrderCardWidget(order: state.orders[index]);
      },
    );
  }
}
