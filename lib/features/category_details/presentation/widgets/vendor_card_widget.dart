import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/features/category_details/domain/entities/category_company_entity.dart';

class VendorCardWidget extends StatelessWidget {
  final CategoryCompanyEntity company;

  const VendorCardWidget({super.key, required this.company});

  bool get _isOpen => true;

  bool get _hasOffers =>
      company.companyId != null && company.companyId!.hashCode.isEven;

  static const double _rating = 4.5;
  static const int _ratingCount = 138;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final accent = context.mainColor;
    final textColor = isDark ? AppColors.white : AppColors.black;
    final labelColor = isDark ? Colors.white54 : AppColors.grey;
    final cardBg = isDark ? const Color(0xFF0F0F10) : AppColors.white;
    final borderColor =
        isDark ? Colors.white.withOpacity(0.08) : AppColors.lightGrey;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.vendorProfile,
          arguments: company.companyId,
        ),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.35)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _VendorLogo(
                    logoUrl: company.logoUrl,
                    isDark: isDark,
                    accent: accent,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                company.companyName ?? 'Premium Store',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  color: textColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            _StatusBadge(isOpen: _isOpen),
                          ],
                        ),
                        if (company.businessTypeName?.isNotEmpty == true) ...[
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              Icon(
                                Icons.storefront_outlined,
                                size: 12.sp,
                                color: labelColor,
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  company.businessTypeName!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.outfit(
                                    color: labelColor,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: 6.h),
                        _StarRatingBar(
                          rating: _rating,
                          ratingCount: _ratingCount,
                          labelColor: labelColor,
                        ),
                        SizedBox(height: 10.h),
                        _VendorInfoRow(
                          company: company,
                          textColor: textColor,
                          labelColor: labelColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_hasOffers)
                Positioned(
                  right: -10.w,
                  bottom: 4.h,
                  child: const _OffersRibbon(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VendorLogo extends StatelessWidget {
  final String? logoUrl;
  final bool isDark;
  final Color accent;

  const _VendorLogo({
    required this.logoUrl,
    required this.isDark,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? Colors.white12 : AppColors.whiteGrey,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11.r),
        child: CachedNetworkImage(
          imageUrl: logoUrl ?? '',
          fit: BoxFit.contain,
          placeholder: (_, __) => Center(
            child: SizedBox(
              width: 20.w,
              height: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: accent.withOpacity(0.5),
              ),
            ),
          ),
          errorWidget: (_, __, ___) => Icon(
            Icons.storefront_rounded,
            color: accent.withOpacity(0.7),
            size: 28.sp,
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isOpen;

  const _StatusBadge({required this.isOpen});

  @override
  Widget build(BuildContext context) {
    final color = isOpen ? AppColors.linearColor : AppColors.red;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          isOpen ? 'Open' : 'Closed',
          style: GoogleFonts.outfit(
            color: color,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _StarRatingBar extends StatelessWidget {
  final double rating;
  final int ratingCount;
  final Color labelColor;

  const _StarRatingBar({
    required this.rating,
    required this.ratingCount,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          final fill = (rating - index).clamp(0.0, 1.0);
          return Padding(
            padding: EdgeInsets.only(right: 1.w),
            child: SizedBox(
              width: 14.sp,
              height: 14.sp,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 14.sp,
                    color: labelColor.withOpacity(0.25),
                  ),
                  if (fill > 0)
                    ClipRect(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: fill,
                        child: Icon(
                          Icons.star_rounded,
                          size: 14.sp,
                          color: const Color(0xffFFC107),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
        SizedBox(width: 6.w),
        Flexible(
          child: Text(
            '($ratingCount ratings)',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              color: labelColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _VendorInfoRow extends StatelessWidget {
  final CategoryCompanyEntity company;
  final Color textColor;
  final Color labelColor;

  const _VendorInfoRow({
    required this.company,
    required this.textColor,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: _InfoCell(
              icon: Icons.category_outlined,
              label: 'Category',
              value: company.categoryName ?? '-',
              textColor: textColor,
              labelColor: labelColor,
            ),
          ),
          _VerticalDivider(color: labelColor.withOpacity(0.3)),
          Expanded(
            child: _InfoCell(
              icon: Icons.location_on_outlined,
              label: 'Location',
              value: company.locationName ?? '-',
              textColor: textColor,
              labelColor: labelColor,
            ),
          ),
          _VerticalDivider(color: labelColor.withOpacity(0.3)),
          Expanded(
            child: _InfoCell(
              icon: Icons.verified_outlined,
              label: 'Status',
              value: 'Verified',
              textColor: textColor,
              labelColor: labelColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color textColor;
  final Color labelColor;

  const _InfoCell({
    required this.icon,
    required this.label,
    required this.value,
    required this.textColor,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(icon, size: 11.sp, color: labelColor),
            SizedBox(width: 3.w),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  color: labelColor,
                  fontSize: 9.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            color: textColor,
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  final Color color;

  const _VerticalDivider({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Container(width: 1, color: color),
    );
  }
}

class _OffersRibbon extends StatelessWidget {
  const _OffersRibbon();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.785398,
      child: Container(
        width: 68.w,
        padding: EdgeInsets.symmetric(vertical: 3.h),
        decoration: BoxDecoration(
          gradient: AppColors.linearLight,
          boxShadow: [
            BoxShadow(
              color: AppColors.mainColor.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          'OFFERS',
          style: GoogleFonts.outfit(
            color: AppColors.white,
            fontSize: 8.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
