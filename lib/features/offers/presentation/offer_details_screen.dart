import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/functions/show_snakbar.dart';
import 'package:tradehub/core/utils/animations/loading_product_animation.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/offers/data/models/add_offer_request_body.dart';
import 'package:tradehub/features/offers/data/models/offers_response.dart';
import 'package:tradehub/features/offers/presentation/cubit/cubit.dart';
import 'package:tradehub/features/offers/presentation/cubit/state.dart';

final Map<String, dynamic> offerData = {
  "pageIndex": 1,
  "pageSize": 10,
  "count": 1,
  "data": [
    {
      "id": 1,
      "name": "Big Mac",
      "description": "Big Mac + Cola",
      "companyId": "16b329d3-6e81-4c10-a3c0-3b12efe47be6",
      "companyName": "McDonalds Egypt",
      "logoUrlCompany":
          "http://tradehub.runasp.net/images/companies/f5273e36-c522-4a61-805e-3522cdb1ad3f.jpg",
      "offerType": "PercentageDiscount",
      "discountPercentage": 20.00,
      "originalTotalPrice": 155,
      "finalPrice": 124.00,
      "savedAmount": 31.00,
      "startDate": "2026-06-15T00:00:00",
      "endDate": "2026-07-15T00:00:00",
      "isActive": true,
      "isCurrentlyActive": true,
      "items": [
        {
          "productId": 36,
          "productName": "Big Mac",
          "productImage":
              "http://tradehub.runasp.net/images/products/8be589e3-3609-4910-8751-23f7e74b7866.jpg",
          "price": 120,
          "quantity": 1,
          "isGift": false,
        },
        {
          "productId": 43,
          "productName": "Coca Cola",
          "productImage":
              "http://tradehub.runasp.net/images/products/2eee9cee-2d28-4d14-8ba9-f6dce02366c6.jpg",
          "price": 35,
          "quantity": 1,
          "isGift": false,
        },
      ],
    }
  ],
};

class OfferDetailScreen extends StatefulWidget {
  const OfferDetailScreen({super.key, required this.id});
  final int id;
  @override
  State<OfferDetailScreen> createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _slideController;
  late final Animation<double> _pulseAnim;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;
  bool _addedToCart = false;
  bool isSnackbarShown = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );
  }
  int getDaysLeft(OfferResponse? offer) {
  if (offer == null || offer.endDate!.isEmpty) return 0;

  final end = DateTime.parse(offer.endDate!);
  return end.difference(DateTime.now()).inDays;
}

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OffersCubit>()..getOfferDetails(widget.id),
      child: BlocBuilder<OffersCubit, OffersState>(builder: (context, state) {
        final offer = context.read<OffersCubit>().offerResponse;
        final List<OfferProductItemResponse>? items = offer?.items;
        final double saved = offer?.savedAmount ?? 0.00;
        final double original = offer?.originalTotalPrice ?? 0.00;
        final double final_ = offer?.finalPrice ?? 0.00;
        final double discount = offer?.discountPercentage ?? 0.00;
        final String endDate = offer?.endDate ?? "";
        final String startDate = offer?.startDate ?? "";
        final bool active = offer?.isCurrentlyActive ?? false;
        int daysLeft = 0;

        if (state is AddOfferToCartLoaded && isSnackbarShown == false) {
          showSuccessSnackBar(messageTitle: " Offer Added Successfully");
          context.read<CartCubit>().isCartChanged = true;
          isSnackbarShown = true;
        } else if (state is AddOfferToCartError && isSnackbarShown == false) {
          showFailureSnackBar(context, messageTitle: "Failed To Add Offer");
          isSnackbarShown = true;
        }
        daysLeft = getDaysLeft(offer);
        if (state is AddOfferToCartError) {
          showFailureSnackBar(context, messageTitle: state.message);
        }

        return state is OfferDetailsLoading
            ? Center(child: loadingProductAnimation())
            : Scaffold(
                backgroundColor: const Color(0xFF0F0F0F),
                body: Stack(
                  children: [
                    // ── Scrollable body ────────────────────────────────────────────
                    CustomScrollView(
                      slivers: [
                        // App bar with hero image mosaic
                        SliverAppBar(
                          expandedHeight: 280,
                          pinned: true,
                          backgroundColor: const Color(0xFF1A1A1A),
                          leading: GestureDetector(
                            onTap: () => Navigator.maybePop(context),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.arrow_back_ios_new,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            background: _buildHeroSection(items, offer),
                          ),
                        ),
                        // Content
                        SliverToBoxAdapter(
                          child: FadeTransition(
                            opacity: _fadeAnim,
                            child: SlideTransition(
                              position: _slideAnim,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 24, 20, 120),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildOfferTitleSection(
                                        offer, active, daysLeft),
                                    const SizedBox(height: 24),
                                    _buildSavingsBanner(saved, discount),
                                    const SizedBox(height: 24),
                                    _buildPriceBreakdown(
                                        original, final_, saved),
                                    const SizedBox(height: 24),
                                    _buildWhatYouGet(items),
                                    const SizedBox(height: 24),
                                    _buildValiditySection(
                                        startDate, endDate, daysLeft),
                                    const SizedBox(height: 24),
                                    _buildWhyThisOffer(offer),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ── Sticky bottom bar ──────────────────────────────────────────
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _buildBottomBar(final_, saved, offer?.id ?? 0),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  // ── Hero image mosaic ────────────────────────────────────────────────────
  Widget _buildHeroSection(
      List<OfferProductItemResponse>? items, OfferResponse? offer) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2A1500), Color(0xFF0F0F0F)],
            ),
          ),
        ),
        // Product images side by side
        Row(
          children: items!.map((item) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Image.network(
                  item.productImage ?? "",
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.fastfood,
                    size: 80,
                    color: Colors.white24,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        // Discount badge
        Positioned(
          top: 60,
          right: 16,
          child: AnimatedBuilder(
            animation: _pulseAnim,
            builder: (_, child) => Transform.scale(
              scale: _pulseAnim.value,
              child: child,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B00),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF6B00).withOpacity(0.5),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 4),
                  Text(
                    '${(offer?.discountPercentage as num).toInt()}% OFF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Bottom fade
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xFF0F0F0F)],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Title + company + status ─────────────────────────────────────────────
  Widget _buildOfferTitleSection(
      OfferResponse? offer, bool active, int daysLeft) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company row
        Row(
          children: [
            ClipOval(
              child: Image.network(
                offer?.logoUrlCompany ?? "",
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 32,
                  height: 32,
                  color: const Color(0xFFFFC107),
                  child: const Icon(Icons.store, size: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              offer?.companyName ?? "",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (active)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A1E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF4CAF50), width: 1),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.circle, color: Color(0xFF4CAF50), size: 8),
                    SizedBox(width: 4),
                    Text('Live Now',
                        style:
                            TextStyle(color: Color(0xFF4CAF50), fontSize: 11)),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),
        // Offer name
        Text(
          offer?.name ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        // Description
        Text(
          offer?.description ?? "",
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        if (daysLeft >= 0 && daysLeft < 3) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF3A1A00),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: const Color(0xFFFF6B00).withOpacity(0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('⏰', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(
                  daysLeft == 1
                      ? 'Last day! Grab it before it\'s gone'
                      : 'Only $daysLeft days left — don\'t miss it!',
                  style:
                      const TextStyle(color: Color(0xFFFF9800), fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // ── Savings banner ───────────────────────────────────────────────────────
  Widget _buildSavingsBanner(double saved, double discount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A1500), Color(0xFF1A0A00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFF6B00).withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                'You\'re Saving Real Money',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  color: Colors.white70, fontSize: 14, height: 1.6),
              children: [
                const TextSpan(text: 'This bundle gives you '),
                TextSpan(
                  text: '${discount.toInt()}% off',
                  style: const TextStyle(
                    color: Color(0xFFFF9800),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const TextSpan(
                    text:
                        ' the regular price. Instead of paying full price for each item separately, you get everything bundled at a '),
                TextSpan(
                  text: '${saved.toInt()} EGP discount',
                  style: const TextStyle(
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const TextSpan(
                    text: ' — that\'s money back in your pocket. 💚'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Price breakdown ──────────────────────────────────────────────────────
  Widget _buildPriceBreakdown(double original, double final_, double saved) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Breakdown',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              _priceRow(
                icon: Icons.receipt_long_outlined,
                iconColor: Colors.white38,
                label: 'Original Price',
                value: '${original.toInt()} EGP',
                valueStyle: const TextStyle(
                  color: Colors.white38,
                  fontSize: 15,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.white38,
                ),
                showDivider: true,
              ),
              _priceRow(
                icon: Icons.local_offer_outlined,
                iconColor: const Color(0xFFFF9800),
                label: 'Offer Price',
                value: '${final_.toInt()} EGP',
                valueStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                showDivider: true,
              ),
              _priceRow(
                icon: Icons.savings_outlined,
                iconColor: const Color(0xFF4CAF50),
                label: 'You Save',
                value: '- ${saved.toInt()} EGP 🎉',
                valueStyle: const TextStyle(
                  color: Color(0xFF4CAF50),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                showDivider: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _priceRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required TextStyle valueStyle,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 12),
              Text(label,
                  style: const TextStyle(color: Colors.white60, fontSize: 14)),
              const Spacer(),
              Text(value, style: valueStyle),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: 1, color: Color(0xFF2A2A2A), indent: 16),
      ],
    );
  }

  // ── What you get ─────────────────────────────────────────────────────────
  Widget _buildWhatYouGet(List<OfferProductItemResponse>? items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What's in This Offer",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Every item below is included in the bundle price.',
          style: TextStyle(color: Colors.white38, fontSize: 13),
        ),
        const SizedBox(height: 16),
        ...items!.map((item) => _buildItemRow(item)),
      ],
    );
  }

  Widget _buildItemRow(OfferProductItemResponse item) {
    final bool isGift = item.isGift as bool;
    final double price = (item.price as num).toDouble();
    final int qty = item.quantity as int;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: isGift
            ? Border.all(color: const Color(0xFF4CAF50).withOpacity(0.4))
            : null,
      ),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.productImage!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 60,
                height: 60,
                color: const Color(0xFF2A2A2A),
                child:
                    const Icon(Icons.fastfood, color: Colors.white24, size: 28),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.productName!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isGift) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A1E),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('🎁 Free',
                            style: TextStyle(
                                color: Color(0xFF4CAF50), fontSize: 11)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Qty: $qty',
                  style: const TextStyle(color: Colors.white38, fontSize: 13),
                ),
              ],
            ),
          ),
          // Price
          Text(
            isGift ? 'FREE' : '${price.toInt()} EGP',
            style: TextStyle(
              color: isGift ? const Color(0xFF4CAF50) : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ── Validity ─────────────────────────────────────────────────────────────
  Widget _buildValiditySection(String startDate, String endDate, int daysLeft) {
    final total =
        DateTime.parse(endDate).difference(DateTime.parse(startDate)).inDays;
    final elapsed = DateTime.now()
        .difference(DateTime.parse(startDate))
        .inDays
        .clamp(0, total);
    final progress = (elapsed / total).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Offer Validity',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _dateChip(
                      '📅 Starts',
                      DateFormat('MMM d, yyyy')
                          .format(DateTime.parse(startDate))),
                  const Icon(Icons.arrow_forward,
                      color: Colors.white24, size: 18),
                  _dateChip(
                      '🏁 Ends',
                      DateFormat('MMM d, yyyy')
                          .format(DateTime.parse(endDate))),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: const Color(0xFF2A2A2A),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    daysLeft <= 3
                        ? const Color(0xFFFF6B00)
                        : const Color(0xFF4CAF50),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                daysLeft > 0 ? '$daysLeft days remaining' : 'Offer has ended',
                style: TextStyle(
                  color:
                      daysLeft <= 3 ? const Color(0xFFFF9800) : Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dateChip(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white38, fontSize: 11)),
        const SizedBox(height: 4),
        Text(date,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  // ── Why this offer ───────────────────────────────────────────────────────
  Widget _buildWhyThisOffer(OfferResponse? offer) {
    final double saved = (offer?.savedAmount as num).toDouble();
    final String company = offer?.companyName ?? "";
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F0D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: const Color(0xFF4CAF50).withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('💡', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text(
                'Why grab this offer?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _whyBullet('🔥',
              'Exclusive bundle from $company — not sold separately at this price'),
          _whyBullet('💰',
              'You save ${saved.toInt()} EGP instantly — no codes, no conditions'),
          _whyBullet('✅',
              'Everything you need in one tap — just add to cart and enjoy'),
          _whyBullet('⏳',
              'Limited-time deal — once it\'s gone, it\'s full price again'),
        ],
      ),
    );
  }

  Widget _whyBullet(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 15)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white70, fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom bar ───────────────────────────────────────────────────────────
  Widget _buildBottomBar(double finalPrice, double saved, int id) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF141414),
        border: Border(top: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
      child: Row(
        children: [
          // Price summary
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${finalPrice.toInt()} EGP',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '🔥 Save ${saved.toInt()} EGP',
                style: const TextStyle(
                  color: Color(0xFF4CAF50),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Add to cart button
          BlocBuilder<OffersCubit, OffersState>(builder: (context, state) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  !_addedToCart
                      ? context.read<OffersCubit>().addOfferToCart(
                              addOfferRequestBody: AddOfferRequestBody(
                            offerId: id,
                            quantity: 1,
                          ))
                      : null;
                  setState(() {
                    _addedToCart = true;
                  });

                  HapticFeedback.mediumImpact();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: _addedToCart
                        ? const Color(0xFF1E3A1E)
                        : const Color(0xFFFF6B00),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: _addedToCart
                        ? []
                        : [
                            BoxShadow(
                              color: const Color(0xFFFF6B00).withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _addedToCart ? '✅' : '🛒',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _addedToCart ? 'Added to Cart!' : 'Add Offer to Cart',
                        style: TextStyle(
                          color: _addedToCart
                              ? const Color(0xFF4CAF50)
                              : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
