import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/features/your_orders/presentation/cubit/orders_cubit.dart';
import 'package:tradehub/features/your_orders/presentation/widgets/order_status_filter_bar.dart';

import 'widgets/your_orders_screen_body.dart';

class YourOrdersScreen extends StatelessWidget {
  const YourOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<OrdersCubit>()..getOrders(isRefresh: true),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: MainLayoutAppBar(
              title: tr(LocaleKeys.yourOrders),
              enableLeading: false,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                const OrderStatusFilterBar(),
                SizedBox(height: 8.h),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await context
                          .read<OrdersCubit>()
                          .getOrders(isRefresh: true);
                    },
                    color: context.mainColor,
                    strokeWidth: 2,
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    child: const YourOrdersScreenBody(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
