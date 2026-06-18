import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';
import 'package:tradehub/core/utils/storage/hive_storage.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/features/checkout/data/models/request/checkout_request_d_t_o.dart';
import 'package:tradehub/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:tradehub/features/checkout/presentation/payment_webview_screen.dart';
import 'package:tradehub/features/checkout/data/models/response/payment_webhook_response_d_t_o.dart';
import 'widgets/checkout_step.dart';
import 'widgets/collapsed_shipping_card.dart';
import 'widgets/edit_shipping_sheet.dart';
import 'widgets/payment_method_step.dart';
import 'widgets/order_summary_card.dart';
import 'widgets/sticky_bottom_bar.dart';

class CheckoutScreenBody extends StatefulWidget {
  const CheckoutScreenBody({super.key, required this.onCheckout});
  final Function({required bool isCheckoutSucess}) onCheckout;

  @override
  State<CheckoutScreenBody> createState() => _CheckoutScreenBodyState();
}

class _CheckoutScreenBodyState extends State<CheckoutScreenBody> {
  String recipientName = "";
  String phoneNumber = "";
  String shippingAddress = "";
  String selectedMapPlace = ""; // Place selected from in-app map
  int selectedPaymentMethod = 0; // 0 for Credit Card, 1 for COD
  int activeStep = 1; // 1 for Payment Method, 2 for Review & Place Order
  bool isCheckedOut = false;
  bool isPaying = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() {
    final userInfo = getIt<HiveStorageHelper>().getMap(AppConstants.userInfo);
    recipientName = userInfo?[ApiConstants.fullName] ?? "Guest User";
    // Load phone from Hive — try both keys
    phoneNumber = (userInfo?[ApiConstants.phoneNumber] ??
            userInfo?[ApiConstants.phone] ??
            "")
        .toString();

    final cubit = context.read<CheckoutCubit>();
    // If cubit.address contains our custom format "Name | Phone | Address", parse it
    final rawAddress = cubit.address ??
        getIt<SharedPrefsHelper>().getString(AppConstants.savedPlace) ??
        "";

    if (rawAddress.contains(" | ")) {
      final parts = rawAddress.split(" | ");
      if (parts.length >= 3) {
        recipientName = parts[0];
        phoneNumber = parts[1];
        shippingAddress = parts.sublist(2).join(" | ");
      } else {
        shippingAddress = rawAddress;
      }
    } else {
      shippingAddress = rawAddress;
    }

    // Pre-fill map place from saved prefs
    final savedPlace =
        getIt<SharedPrefsHelper>().getString(AppConstants.savedPlace) ?? "";
    selectedMapPlace = savedPlace;
    // If shipping address wasn't set from a formatted address, use saved place
    if (shippingAddress.isEmpty && savedPlace.isNotEmpty) {
      shippingAddress = savedPlace;
    }
  }

  void _openEditShippingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditShippingSheet(
        initialName: recipientName,
        initialPhone: phoneNumber,
        initialAddress: shippingAddress,
        onSave: (name, phone, address) {
          setState(() {
            recipientName = name;
            phoneNumber = phone;
            shippingAddress = address;
          });
        },
      ),
    );
  }

  /// Opens the in-app map screen and updates [selectedMapPlace] and [shippingAddress] with the result.
  Future<void> _openMapScreen() async {
    final result = await Navigator.pushNamed(context, Routes.flutterMap);
    if (result != null && result is String && result.isNotEmpty) {
      setState(() {
        selectedMapPlace = result;
        // Always sync shipping address to the map selection
        shippingAddress = result;
      });
    }
  }

  /// Builds the effective address string used for the checkout API.
  String _buildEffectiveAddress() {
    final base =
        selectedMapPlace.isNotEmpty ? selectedMapPlace : shippingAddress;
    return "$recipientName | $phoneNumber | $base";
  }

  /// Called when the user taps "Place Order" (step 2).
  Future<void> _placeOrder(
      CheckoutCubit cubit, int selectedPaymentMethod) async {
    final formattedAddress = _buildEffectiveAddress();

    // 1. Call checkout API to create the order
    await cubit.checkout(
      body: CheckoutRequestDTO(
        basketId: cubit.items?.id,
        deliveryFee: 0,
        address: formattedAddress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    final cartItems = cubit.items;
    final subTotal = cartItems?.subTotal ?? 0;

    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          // Checkout succeede  d → proceed to payment based on selected method
          widget.onCheckout(isCheckoutSucess: true);
          setState(() {
            isCheckedOut = true;
          });
        } else if (state is CheckoutError) {
          showFailureSnackBar(context, messageTitle: state.error.message);
        } else if (state is PaymentWebhookSuccess) {
          showSuccessSnackBar(messageTitle: "Order placed successfully!");
        } else if (state is PaymentWebhookError) {
          showFailureSnackBar(context, messageTitle: state.error.message);
        }
      },
      builder: (context, state) {
        final isLoading =
            state is CheckoutLoading || state is PaymentWebhookLoading;

        return Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 24.h,
                  bottom: 120.h, // spacing for sticky bottom bar
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Delivery Location ──────────────────────────────────
                    _buildDeliveryLocationSection(context),
                    SizedBox(height: 20.h),

                    // Step 1: Shipping Address (Always Completed)
                    CheckoutStep(
                      stepNumber: 1,
                      title: "Shipping Address",
                      isCompleted: true,
                      isActive: false,
                      collapsedContent: CollapsedShippingCard(
                        recipientName: recipientName,
                        address: shippingAddress,
                        phoneNumber: phoneNumber,
                        onEdit: _openEditShippingSheet,
                      ),
                    ),

                    // Step 2: Payment Method
                    CheckoutStep(
                      stepNumber: 2,
                      title: "Payment Method",
                      isCompleted: activeStep > 1,
                      isActive: activeStep == 1,
                      activeContent: PaymentMethodStep(
                        selectedMethod: selectedPaymentMethod,
                        onChanged: (index) {
                          setState(() {
                            selectedPaymentMethod = index;
                          });
                        },
                      ),
                      collapsedContent: InkWell(
                        onTap: () {
                          setState(() {
                            activeStep = 1;
                          });
                        },
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? const Color(0xFF1E1E20)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: context.isDarkMode
                                  ? Colors.white10
                                  : Colors.black.withOpacity(0.04),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selectedPaymentMethod == 0
                                    ? Icons.credit_card_outlined
                                    : Icons.payments_outlined,
                                color: context.mainColor,
                                size: 20.sp,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                selectedPaymentMethod == 0
                                    ? "Credit/Debit Card"
                                    : "Cash on Delivery (COD)",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: context.isDarkMode
                                      ? Colors.white70
                                      : Colors.black87,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: AppColors.grey,
                                size: 20.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Step 3: Review & Place Order
                    CheckoutStep(
                      stepNumber: 3,
                      title: "Review & Place Order",
                      isCompleted: false,
                      isActive: activeStep == 2,
                      isLast: true,
                      activeContent: cartItems != null
                          ? OrderSummaryCard(
                              items: cartItems.items ?? [],
                              subTotal: subTotal,
                              initiallyExpanded: true,
                            )
                          : const SizedBox.shrink(),
                      collapsedContent: cartItems != null
                          ? OrderSummaryCard(
                              items: cartItems.items ?? [],
                              subTotal: subTotal,
                              initiallyExpanded: false,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Section
            Align(
              alignment: Alignment.bottomCenter,
              child: StickyBottomBar(
                totalPrice: subTotal,
                buttonText: activeStep == 1
                    ? "Continue"
                    : isCheckedOut
                        ? "Pay Now"
                        : "Place Order",
                isLoading: isLoading,
                onTap: () async {
                  if (activeStep == 1) {
                    setState(() {
                      activeStep = 2;
                    });
                  } else {
                    // Place order: call checkout API, then handle payment
                    if (!isCheckedOut) {
                      if (shippingAddress.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.black,
                            content: Row(
                              children: [
                                const Icon(Icons.info_outline,
                                    color: Colors.white),
                                Text(
                                  "Please select your shipping address",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      if (shippingAddress.isNotEmpty) {
                        await _placeOrder(cubit, selectedPaymentMethod);
                      }
                    } else {
                      final paymentUrl = cubit.checkoutResponse?.paymentUrl;

                      if (paymentUrl != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PaymentWebViewScreen(
                              url: paymentUrl,
                              cubit: cubit,
                            ),
                          ),
                        );
                      }
                    }
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // ── Delivery Location Section ──────────────────────────────────────────────

  Widget _buildDeliveryLocationSection(BuildContext context) {
    final isDark = context.isDarkMode;
    final primary = context.mainColor;
    final hasPlace = selectedMapPlace.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DELIVERY LOCATION",
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white38 : Colors.black38,
            letterSpacing: 1.4,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: _openMapScreen,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              gradient: hasPlace
                  ? LinearGradient(
                      colors: [
                        primary.withOpacity(isDark ? 0.25 : 0.08),
                        primary.withOpacity(isDark ? 0.12 : 0.03),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: hasPlace
                  ? null
                  : (isDark ? const Color(0xFF1E1E20) : Colors.white),
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: hasPlace
                    ? primary.withOpacity(0.35)
                    : (isDark
                        ? Colors.white12
                        : Colors.black.withOpacity(0.06)),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: hasPlace
                      ? primary.withOpacity(0.12)
                      : Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Map pin icon container
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: hasPlace
                        ? primary.withOpacity(0.15)
                        : (isDark
                            ? Colors.white10
                            : Colors.black.withOpacity(0.05)),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    hasPlace ? Icons.location_pin : Icons.near_me_rounded,
                    color: hasPlace ? primary : AppColors.grey,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasPlace
                            ? "Selected Location"
                            : "Set Delivery Location",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: hasPlace ? primary : AppColors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        hasPlace
                            ? selectedMapPlace
                            : "Tap to open map and pick your address",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight:
                              hasPlace ? FontWeight.w700 : FontWeight.w400,
                          color: hasPlace
                              ? (isDark ? Colors.white : Colors.black87)
                              : AppColors.grey,
                          fontFamily: 'Poppins',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  hasPlace
                      ? Icons.edit_location_alt_rounded
                      : Icons.chevron_right_rounded,
                  color: hasPlace ? primary : AppColors.grey,
                  size: 22.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
