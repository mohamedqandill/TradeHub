import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/features/main_layout/home/presentation/widgets/home_category_widget.dart';
import 'package:tradehub/features/offers/data/models/offers_response.dart';

// If your app toggles dark mode through a custom extension (like the
// `context.greyOrWhite` you use in the cart screen), import it and swap the
// detection line in `_BundleCardColors.of` (see the comment there).
// import 'package:tradehub/core/extensions/main_color.dart';

// ─── Theme-aware colors (compact bundle card) ───────────────────────────────
class _BundleCardColors {
  final Color cardBackground;
  final Color dashedBorder;
  final Color imageBoxBackground;
  final Color imageBoxBorder;
  final Color divider;
  final Color primaryText;
  final Color mutedText;
  final Color faintText;
  final Color iconMuted;
  final Color badgeBackground;
  final Color savedChipBackground;
  final Color accent;

  const _BundleCardColors({
    required this.cardBackground,
    required this.dashedBorder,
    required this.imageBoxBackground,
    required this.imageBoxBorder,
    required this.divider,
    required this.primaryText,
    required this.mutedText,
    required this.faintText,
    required this.iconMuted,
    required this.badgeBackground,
    required this.savedChipBackground,
    required this.accent,
  });

  factory _BundleCardColors.of(BuildContext context) {
    // ── DARK-MODE DETECTION ──────────────────────────────────────────────
    // Default: Flutter's active theme brightness.
    final bool isDark = context.isDarkMode;
    //
    // If your app switches theme via your own extension/cubit (the same source
    // that powers `context.greyOrWhite`), replace the line above with:
    //   final bool isDark = context.isDark;   // <- your extension's getter
    // ─────────────────────────────────────────────────────────────────────

    if (isDark) {
      // ── DARK PALETTE ──
      return const _BundleCardColors(
        cardBackground: Color(0xFF1A1A1A),
        dashedBorder: Color(0xFF4A4A4A),
        imageBoxBackground: Color(0xFF2A2A2A),
        imageBoxBorder: Color(0xFF3A3A3A),
        divider: Color(0xFF2E2E2E),
        primaryText: Colors.white,
        mutedText: Colors.white54,
        faintText: Colors.white60,
        iconMuted: Colors.white38,
        badgeBackground: Color(0xFF242424),
        savedChipBackground: Color(0xFF14321F),
        accent: Color(0xFF4CAF50),
      );
    }

    // ── LIGHT PALETTE ──
    return const _BundleCardColors(
      cardBackground: Color(0xFFFFFFFF),
      dashedBorder: Color(0xFFB5B5B5),
      imageBoxBackground: Color(0xFFF2F2F2),
      imageBoxBorder: Color(0xFFE0E0E0),
      divider: Color(0xFFE6E6E6),
      primaryText: Color(0xFF1A1A1A),
      mutedText: Color(0xFF8A8A8A),
      faintText: Color(0xFF707070),
      iconMuted: Color(0xFFBDBDBD),
      badgeBackground: Color(0xFFF2F2F2),
      savedChipBackground: Color(0xFFE7F6EC),
      accent: Color(0xFF2E9E5B),
    );
  }
}

// ─── Compact Bundle Offer Card ──────────────────────────────────────────────
class BundleOfferCard extends StatelessWidget {
  final OfferResponse bundleOffer;
  final int quantity;
  final ValueChanged<int>? onUpdateQuantity;
  final VoidCallback? onTap;

  const BundleOfferCard({
    super.key,
    required this.bundleOffer,
    required this.quantity,
    this.onUpdateQuantity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _BundleCardColors.of(context);

    final String offerType = bundleOffer.offerType ?? '';
    final double discount = bundleOffer.discountPercentage ?? 0;
    final String saveLabel = offerType == 'PercentageDiscount'
        ? 'SAVE ${discount.toInt()}%'
        : 'OFFER';

    final double original = bundleOffer.originalTotalPrice ?? 0;
    final double finalPrice = bundleOffer.finalPrice ?? 0;
    final double saved = bundleOffer.savedAmount ?? 0;
    final items = bundleOffer.items ?? [];

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
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
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header: bundle name + SAVE badge ──
              Row(
                children: [
                  Icon(Icons.local_offer_rounded,
                      size: 15.sp, color: colors.accent),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      bundleOffer.name ?? 'Bundle Offer',
                      style: TextStyle(
                        color: colors.primaryText,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: colors.badgeBackground,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: colors.accent, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🔥', style: TextStyle(fontSize: 11.sp)),
                        SizedBox(width: 3.w),
                        Text(
                          saveLabel,
                          style: TextStyle(
                            color: colors.accent,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),

              // ── Description ──
              if ((bundleOffer.description ?? '').isNotEmpty)
                Text(
                  bundleOffer.description!,
                  style: TextStyle(
                    color: colors.faintText,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              SizedBox(height: 10.h),

              // ── Bundled product thumbnails + saved chip ──
              Row(
                children: [
                  for (int i = 0; i < items.length && i < 3; i++) ...[
                    _thumb(items[i].productImage ?? '', colors),
                    if (i < items.length - 1 && i < 2) ...[
                      SizedBox(width: 6.w),
                      Text('+',
                          style: TextStyle(
                              color: colors.mutedText, fontSize: 14.sp)),
                      SizedBox(width: 6.w),
                    ],
                  ],
                  const Spacer(),
                  if (saved > 0)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: colors.savedChipBackground,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        '💰 Save ${saved.toInt()} EGP',
                        style: TextStyle(
                          color: colors.accent,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10.h),

              Container(height: 1, color: colors.divider),
              SizedBox(height: 10.h),

              // ── Price row + quantity stepper ──
              Row(
                children: [
                  Text(
                    '${original.toInt()} EGP',
                    style: TextStyle(
                      color: colors.mutedText,
                      fontSize: 12.sp,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: colors.mutedText,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.arrow_forward,
                      color: colors.mutedText, size: 13.sp),
                  SizedBox(width: 8.w),
                  Text(
                    '${finalPrice.toInt()} EGP',
                    style: TextStyle(
                      color: colors.primaryText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  _quantityStepper(colors),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _thumb(String url, _BundleCardColors colors) {
    return Container(
      width: 38.w,
      height: 38.h,
      decoration: BoxDecoration(
        color: colors.imageBoxBackground,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: colors.imageBoxBorder),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Icon(Icons.fastfood, size: 18.sp, color: colors.iconMuted),
        ),
      ),
    );
  }

  Widget _quantityStepper(_BundleCardColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.imageBoxBackground,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colors.imageBoxBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stepBtn(
            icon: quantity > 1 ? Icons.remove : Icons.delete_outline_rounded,
            color: colors.primaryText,
            onTap: () => onUpdateQuantity?.call(quantity - 1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              '$quantity',
              style: TextStyle(
                color: colors.primaryText,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          _stepBtn(
            icon: Icons.add,
            color: colors.primaryText,
            onTap: () => onUpdateQuantity?.call(quantity + 1),
          ),
        ],
      ),
    );
  }

  Widget _stepBtn({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Icon(icon, size: 16.sp, color: color),
      ),
    );
  }
}

// ─── Dashed Border Painter ──────────────────────────────────────────────────
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