import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/core/utils/animations/loading_product_animation.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/offers/data/models/offers_response.dart';
import 'package:tradehub/features/offers/presentation/cubit/cubit.dart';
import 'package:tradehub/features/offers/presentation/cubit/state.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OffersCubit>()..getOffers(),
      child: BlocBuilder<OffersCubit, OffersState>(builder: (context, state) {
        if (state is OffersLoaded) {
          return Scaffold(
            appBar:
                const MainLayoutAppBar(title: "Offers", enableLeading: true),
            body: SafeArea(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.offersResponse.data?.length ?? 0,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final offer = state.offersResponse.data![index];

                  return OfferCard(offer: offer);
                },
              ),
            ),
          );
        } else {
          return loadingProductAnimation();
        }
      }),
    );
  }
}

// ─── Theme-aware colors ──────────────────────────────────────────────────────
//
// Dark mode preserves the exact original palette.
// Light mode provides matching equivalents while keeping the same design.

class _OfferCardColors {
  final Color cardBackground;
  final Color dashedBorder;
  final Color imageBoxBackground;
  final Color imageBoxBorder;
  final Color divider;
  final Color primaryText; // was Colors.white
  final Color secondaryText; // was Colors.white70 / white60
  final Color mutedText; // was Colors.white54
  final Color faintText; // was Colors.white38 / white54
  final Color iconMuted; // was Colors.white38
  final Color activeDot;
  final Color inactiveDot;

  const _OfferCardColors({
    required this.cardBackground,
    required this.dashedBorder,
    required this.imageBoxBackground,
    required this.imageBoxBorder,
    required this.divider,
    required this.primaryText,
    required this.secondaryText,
    required this.mutedText,
    required this.faintText,
    required this.iconMuted,
    required this.activeDot,
    required this.inactiveDot,
  });

  factory _OfferCardColors.of(BuildContext context) {
    final bool isDark = context.isDarkMode;

    if (isDark) {
      // ── Original dark palette (unchanged) ──
      return const _OfferCardColors(
        cardBackground: Color(0xFF1A1A1A),
        dashedBorder: Color(0xFF4A4A4A),
        imageBoxBackground: Color(0xFF2A2A2A),
        imageBoxBorder: Color(0xFF3A3A3A),
        divider: Color(0xFF2E2E2E),
        primaryText: Colors.white,
        secondaryText: Colors.white70,
        mutedText: Colors.white54,
        faintText: Colors.white54,
        iconMuted: Colors.white38,
        activeDot: Color(0xFF4CAF50),
        inactiveDot: Color(0xFF9E9E9E),
      );
    }

    // ── Light palette (matching equivalents) ──
    return const _OfferCardColors(
      cardBackground: Color(0xFFFFFFFF),
      dashedBorder: Color(0xFFB5B5B5),
      imageBoxBackground: Color(0xFFF2F2F2),
      imageBoxBorder: Color(0xFFE0E0E0),
      divider: Color(0xFFE6E6E6),
      primaryText: Color(0xFF1A1A1A),
      secondaryText: Color(0xFF555555),
      mutedText: Color(0xFF8A8A8A),
      faintText: Color(0xFF9E9E9E),
      iconMuted: Color(0xFFBDBDBD),
      activeDot: Color(0xFF4CAF50),
      inactiveDot: Color(0xFF9E9E9E),
    );
  }
}

// ─── Card Widget ─────────────────────────────────────────────────────────────

class OfferCard extends StatelessWidget {
  final OfferResponse offer;

  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final colors = _OfferCardColors.of(context);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.offerDetails, arguments: offer.id);
      },
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: colors.dashedBorder,
          strokeWidth: 1.2,
          dashWidth: 6,
          dashSpace: 4,
          borderRadius: 12,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusRow(colors),
              SizedBox(height: 12.h),
              _buildCompanyRow(colors),
              SizedBox(height: 14.h),
              _buildProductImages(colors),
              SizedBox(height: 14.h),
              _buildDivider(colors),
              SizedBox(height: 10.h),
              _buildDescription(colors),
              SizedBox(height: 10.h),
              _buildSavings(colors),
              SizedBox(height: 10.h),
              _buildPriceRow(colors),
              SizedBox(height: 10.h),
              _buildDivider(colors),
              SizedBox(height: 10.h),
              _buildFooterRow(colors),
            ],
          ),
        ),
      ),
    );
  }

  // ── Status row: Active  •  🔥 SAVE 20% ──────────────────────────────────

  Widget _buildStatusRow(_OfferCardColors colors) {
    final bool active = offer.isCurrentlyActive ?? false;
    final String offerType = offer.offerType ?? '';
    final double discount = offer.discountPercentage ?? 0;

    final String saveLabel = offerType == 'PercentageDiscount'
        ? 'SAVE ${discount.toInt()}%'
        : 'SPECIAL OFFER';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 10.w,
              height: 10.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? colors.activeDot : colors.inactiveDot,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              active ? 'Active' : 'Inactive',
              style: TextStyle(color: colors.primaryText, fontSize: 14),
            ),
          ],
        ),
        Row(
          children: [
            Text('🔥', style: TextStyle(fontSize: 14.sp)),
            SizedBox(width: 4.w),
            Text(
              saveLabel,
              style: TextStyle(
                color: colors.primaryText,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Company logo + name ──────────────────────────────────────────────────

  Widget _buildCompanyRow(_OfferCardColors colors) {
    final String companyName = offer.companyName ?? '';
    final String logoUrl = offer.logoUrlCompany ?? '';

    return Row(
      children: [
        Container(
          width: 28.w,
          height: 28.h,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: Image.network(
              logoUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.store, size: 16, color: colors.primaryText),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            companyName,
            style: TextStyle(
              color: colors.primaryText,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // ── Product images row ───────────────────────────────────────────────────

  Widget _buildProductImages(_OfferCardColors colors) {
    final List<OfferProductItemResponse> items = offer.items ?? [];
    final display = items.take(3).toList();

    return Row(
      children: [
        for (int i = 0; i < display.length; i++) ...[
          _productImageBox(display[i].productImage ?? '', colors),
          if (i < display.length - 1) ...[
            SizedBox(width: 8.w),
            Text('+',
                style: TextStyle(color: colors.mutedText, fontSize: 18.sp)),
            SizedBox(width: 8.w),
          ],
        ],
      ],
    );
  }

  Widget _productImageBox(String url, _OfferCardColors colors) {
    return Container(
      width: 52.w,
      height: 52.h,
      decoration: BoxDecoration(
        color: colors.imageBoxBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.imageBoxBorder),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Icon(Icons.fastfood, size: 24, color: colors.iconMuted),
        ),
      ),
    );
  }

  // ── Divider ──────────────────────────────────────────────────────────────

  Widget _buildDivider(_OfferCardColors colors) =>
      Container(height: 1, color: colors.divider);

  // ── Description ──────────────────────────────────────────────────────────

  Widget _buildDescription(_OfferCardColors colors) {
    return Text(
      offer.description ?? '',
      style: TextStyle(
        color: colors.primaryText,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // ── Save badge ───────────────────────────────────────────────────────────

  Widget _buildSavings(_OfferCardColors colors) {
    final double saved = offer.savedAmount ?? 0;
    return Row(
      children: [
        Text('💰', style: TextStyle(fontSize: 15.sp)),
        SizedBox(width: 6.w),
        Text(
          'Save ${saved.toInt()} EGP',
          style: TextStyle(color: colors.primaryText, fontSize: 14.sp),
        ),
      ],
    );
  }

  // ── Original → Final price ───────────────────────────────────────────────

  Widget _buildPriceRow(_OfferCardColors colors) {
    final double original = offer.originalTotalPrice ?? 0;
    final double final_ = offer.finalPrice ?? 0;

    return Row(
      children: [
        Text(
          '${original.toInt()} EGP',
          style: TextStyle(
            color: colors.mutedText,
            fontSize: 14.sp,
            decoration: TextDecoration.lineThrough,
            decorationColor: colors.mutedText,
          ),
        ),
        SizedBox(width: 12.w),
        Icon(Icons.arrow_forward, color: colors.mutedText, size: 14),
        const SizedBox(width: 12),
        Text(
          '${final_.toInt()} EGP',
          style: TextStyle(
            color: colors.primaryText,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ── Footer: end date + View Offer ────────────────────────────────────────

  Widget _buildFooterRow(_OfferCardColors colors) {
    final DateTime endDate = DateTime.parse(offer.endDate!);
    final String formattedEnd = DateFormat('MMM d').format(endDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Ends $formattedEnd',
          style: TextStyle(color: colors.secondaryText, fontSize: 13),
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Text(
                'View Offer',
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: colors.primaryText, size: 14),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Dashed Border Painter ───────────────────────────────────────────────────

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  const _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.dashWidth != dashWidth ||
      old.dashSpace != dashSpace ||
      old.borderRadius != borderRadius;
}
