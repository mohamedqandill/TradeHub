import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_states.dart';
import 'package:tradehub/features/main_layout/cart/presentation/widgets/custom_checkout_card.dart';
import 'package:tradehub/features/main_layout/cart/presentation/widgets/empty_cart_screen_body.dart';
import 'package:tradehub/core/shared_widgets/widgets/custom_error_widget.dart';

import 'widgets/custom_cart_card.dart';

class CartScreenBody extends StatefulWidget {
  const CartScreenBody({super.key});

  @override
  State<CartScreenBody> createState() => _CartScreenBodyState();
}

class _CartScreenBodyState extends State<CartScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is RemoveItemError) {
          showFailureSnackBar(context, messageTitle: state.message);
        } else if (state is UpdateItemQuantityError) {
          showFailureSnackBar(context, messageTitle: state.message);
        } else if (state is GetBasketError) {
          showFailureSnackBar(context,
              messageTitle: state.message ?? "An error occurred");
        }
      },
      buildWhen: (previous, current) {
        return current is GetBasketLoading ||
            current is GetBasketSuccess ||
            current is GetBasketError ||
            current is CartInitial;
      },
      builder: (context, state) {
        final cubit = context.read<CartCubit>();

        // Show loading only if we don't have cart data yet
        if ((state is GetBasketLoading || state is CartInitial) &&
            cubit.cart == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cubit.cart != null) {
          final items = cubit.cart!.items;
          final subTotal = cubit.cart!.subTotal;

          if (items.isEmpty) {
            return const EmptyCartScreenBody();
          }

          return Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final int itemIndex = index ~/ 2;
                          if (index.isEven) {
                            final item = items[itemIndex];
                            return Dismissible(
                              key:
                                  Key("cart_item_${item.productId}_${item.id}"),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20.w),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: const Icon(Icons.delete_rounded,
                                    color: Colors.white),
                              ),
                              onDismissed: (_) {
                                cubit.cart!.items.remove(item);
                                setState(() {});
                                cubit.removeItem(item.productId);
                              },
                              child: CustomCartCard(
                                image: item.pictureUrl,
                                title: item.productName,
                                price: item.price.toString(),
                                quantity: item.quantity,
                                onUpdateQuantity: (q) {
                                  cubit.updateItemQuantity(id: item.productId,quantity: q);
                                },
                              ),
                            );
                          }
                          return SizedBox(height: 16.h);
                        },
                        childCount: items.isEmpty ? 0 : (items.length * 2 - 1),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 200.h)),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: DraggableScrollableSheet(
                  initialChildSize: 0.12,
                  minChildSize: 0.11,
                  maxChildSize: 0.35,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? AppColors.black.withOpacity(0.95)
                            : AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.r),
                          topRight: Radius.circular(32.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, -10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 12.h),
                          Container(
                            width: 40.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: CustomCheckoutCard(
                                isLoading: state is RemoveItemLoading ||
                                    state is UpdateItemQuantityLoading,
                                subTotal: subTotal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return CustomErrorWidget(
          message: "Something went wrong loading your cart.",
          onRetry: () => cubit.getBasket(),
        );
      },
    );
  }
}
