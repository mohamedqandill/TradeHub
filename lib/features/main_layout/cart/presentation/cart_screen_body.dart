import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_services/shared_product_repository.dart';
import 'package:tradehub/core/utils/animations/loading_product_animation.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/checkout/data/models/request/checkout_request_d_t_o.dart';
import 'package:tradehub/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:tradehub/features/main_layout/cart/data/models/cart_response_d_t_o.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_states.dart';
import 'package:tradehub/features/main_layout/cart/presentation/widgets/custom_checkout_card.dart';
import 'package:tradehub/features/main_layout/cart/presentation/widgets/empty_cart_screen_body.dart';
import 'package:tradehub/core/shared_widgets/widgets/custom_error_widget.dart';

import 'widgets/custom_cart_card.dart';
import 'widgets/seller_card.dart';

import 'package:flutter_animate/flutter_animate.dart';

import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';

class CartScreenBody extends StatefulWidget {
  const CartScreenBody({super.key});

  @override
  State<CartScreenBody> createState() => _CartScreenBodyState();
}

class _CartScreenBodyState extends State<CartScreenBody>
    with TickerProviderStateMixin {
  TabController? _tabController;
  String placeName = "";

  @override
  void initState() {
    getSavedPlaceName();
    super.initState();
  }

  getSavedPlaceName() {
    placeName = getIt<SharedPrefsHelper>().getString(AppConstants.savedPlace) ??
        "10th of ramadan";
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _initTabController(int length) {
    if (_tabController == null || _tabController!.length != length) {
      _tabController?.dispose();
      _tabController = TabController(length: length, vsync: this);
      _tabController!.addListener(() {
        if (!_tabController!.indexIsChanging) {
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is RemoveItemError) {
          showFailureSnackBar(context, messageTitle: state.message);
        } else if (state is UpdateItemQuantityError) {
          showFailureSnackBar(context, messageTitle: state.message);
        }
        if (state is UpdateItemQuantitySuccess || state is RemoveItemSuccess) {
          context.read<CartCubit>().getBasket();
        }

        if (state is RemoveBasketSuccess || state is RemoveItemSuccess) {
          context.read<CartCubit>().getBasket();
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

        if ((state is GetBasketLoading || state is CartInitial) &&
            cubit.cartGroups == null) {
          return loadingProductAnimation();
        }

        if (cubit.cartGroups != null && cubit.cartGroups!.isNotEmpty) {
          final groups = cubit.cartGroups!;
          _initTabController(groups.length);

          final currentGroup = groups[_tabController!.index];
          final subTotal = currentGroup.subTotal;

          return Column(
            children: [
              _buildCompanyTabBar(groups),
              Expanded(
                child: Stack(
                  children: [
                    TabBarView(
                      controller: _tabController,
                      children: groups.map((group) {
                        return _buildItemsList(cubit, group.items);
                      }).toList(),
                    ),
                    _buildCheckoutSection(
                        state, subTotal, currentGroup.companyName),
                  ],
                ),
              ),
            ],
          );
        }

        if (cubit.cartGroups != null && cubit.cartGroups!.isEmpty) {
          return const EmptyCartScreenBody();
        }

        return CustomErrorWidget(
          message: "Something went wrong loading your cart.",
          onRetry: () => cubit.getBasket(),
        );
      },
    );
  }

  Widget _buildCompanyTabBar(List<CartResponseDTO> groups) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Text(
            "ACTIVE SELLERS (${groups.length})",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
              color: context.greyOrWhite,
              letterSpacing: 1.5,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        SizedBox(
          height: 145.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return SellerCard(
                group: groups[index],
                isSelected: _tabController!.index == index,
                index: index,
                onTap: () {
                  _tabController!.animateTo(index);
                  setState(() {});
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItemsList(CartCubit cubit, List<Items> items) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding:
          EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h, bottom: 50.h),
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key("cart_item_${item.productId}_${item.id}"),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.redAccent.shade100, Colors.redAccent.shade400],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: const Icon(Icons.delete_outline_rounded,
                color: Colors.white, size: 28),
          ),
          confirmDismiss: (_) async {
            setState(() {
              items.removeWhere((element) => element.id == item.id);
            });
            cubit.removeItem(
              companyId: cubit.cartGroups![_tabController!.index].id,
              productId: item.productId,
            );

            return true;
          },
          child: CustomCartCard(
            image: item.pictureUrl,
            title: item.productName,
            price: item.price.toString(),
            quantity: item.quantity,
            options: item.options,
            onUpdateQuantity: (q) {
              if (q == 0) {
                cubit.removeItem(
                  companyId: cubit.cartGroups![_tabController!.index].id,
                  productId: item.productId,
                );
              } else {
                cubit.updateItemQuantity(
                    companyId: cubit.cartGroups![_tabController!.index].id,
                    productId: item.productId,
                    quantity: q);
              }
            },
          ),
        )
            .animate()
            .fadeIn(delay: (index * 50).ms, duration: 400.ms)
            .slideX(begin: 0.1, end: 0);
      },
    );
  }

  Widget _buildCheckoutSection(
      CartState state, int subTotal, String companyName) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BlocProvider<CheckoutCubit>(
        create: (context) => getIt<CheckoutCubit>(),
        child: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutLoading) {
              showDialog(
                context: context,
                builder: (context) => loadingProductAnimation(),
              );
            }
            if (state is CheckoutSuccess) {
              
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.checkout,
                  arguments: context.read<CheckoutCubit>());
            }
            if (state is CheckoutError) {
              Navigator.pop(context);
              showFailureSnackBar(context, messageTitle: state.error.message);
            }
          },
          builder: (context, state) {
            var checkoutCubit = context.read<CheckoutCubit>();
            var cartCubit = context.read<CartCubit>();

            return CustomCheckoutCard(
              onTap: () {
                var body = CheckoutRequestDTO(
                    basketId: cartCubit.cartGroups![_tabController!.index].id,
                    deliveryFee: 0,
                    address: placeName);
                checkoutCubit.getCheckoutData(
                    cartItems: cartCubit.cartGroups![_tabController!.index],
                    address: placeName);
                checkoutCubit.checkout(body: body);
              },
              isLoading: state is CheckoutLoading,
              subTotal: subTotal,
            );
          },
        ),
      ),
    )
        .animate()
        .slideY(begin: 1, end: 0, duration: 600.ms, curve: Curves.easeOutCubic);
  }
}
