import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import '../../data/models/response/product_option_response_dto.dart';

class ProductOptionsSelectionWidget extends StatefulWidget {
  final List<ProductOptionDTO> options;
  final Function(Map<int, List<int>> selectedOptions, int extraPrice) onSelectionChanged;

  const ProductOptionsSelectionWidget({
    super.key,
    required this.options,
    required this.onSelectionChanged,
  });

  @override
  State<ProductOptionsSelectionWidget> createState() =>
      _ProductOptionsSelectionWidgetState();
}

class _ProductOptionsSelectionWidgetState
    extends State<ProductOptionsSelectionWidget> {
  // Map of OptionId -> List of Selected ValueIds
  final Map<int, List<int>> _selectedMap = {};

  @override
  void initState() {
    super.initState();
    _initializeDefaultSelections();
  }

  void _initializeDefaultSelections() {
    for (var option in widget.options) {
      if (option.id == null) continue;
      // If it is required and allowMultiple is false, we can pre-select the first value
      if ((option.isRequired ?? false) && !(option.allowMultiple ?? false)) {
        if (option.values != null && option.values!.isNotEmpty) {
          final firstValId = option.values!.first.id;
          if (firstValId != null) {
            _selectedMap[option.id!] = [firstValId];
          }
        }
      } else {
        _selectedMap[option.id!] = [];
      }
    }
  }

  void _handleSelect(ProductOptionDTO option, ProductOptionValueDTO value) {
    if (option.id == null || value.id == null) return;

    final optionId = option.id!;
    final valueId = value.id!;
    final isMultiple = option.allowMultiple ?? false;

    setState(() {
      final currentSelected = _selectedMap[optionId] ?? [];

      if (isMultiple) {
        if (currentSelected.contains(valueId)) {
          currentSelected.remove(valueId);
        } else {
          currentSelected.add(valueId);
        }
        _selectedMap[optionId] = currentSelected;
      } else {
        // Single selection
        if (currentSelected.contains(valueId)) {
          // If required, we don't allow deselecting the only option unless another is tapped
          if (!(option.isRequired ?? false)) {
            _selectedMap[optionId] = [];
          }
        } else {
          _selectedMap[optionId] = [valueId];
        }
      }
    });

    _notifyParent();
  }

  void _notifyParent() {
    int totalExtraPrice = 0;
    for (var option in widget.options) {
      if (option.id == null || option.values == null) continue;
      final selectedIds = _selectedMap[option.id!] ?? [];
      for (var valId in selectedIds) {
        final val = option.values!.firstWhere((v) => v.id == valId);
        totalExtraPrice += val.extraPrice ?? 0;
      }
    }
    widget.onSelectionChanged(_selectedMap, totalExtraPrice);
  }

  @override
  Widget build(BuildContext context) {
    final textColor = context.isDarkMode ? AppColors.white : AppColors.black;
    final secondaryTextColor = AppColors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.options.map((option) {
        final optionId = option.id ?? 0;
        final selectedIds = _selectedMap[optionId] ?? [];
        final isRequired = option.isRequired ?? false;

        return Container(
          margin: EdgeInsets.only(bottom: 24.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Option Header (Name & Badges)
              Row(
                children: [
                  Text(
                    option.name?.toUpperCase() ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      color: textColor,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  if (isRequired)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "Required",
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.red,
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: secondaryTextColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "Optional",
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w800,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  SizedBox(width: 6.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: context.mainColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      option.allowMultiple ?? false ? "Multi-select" : "Select one",
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w800,
                        color: context.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Option Values list
              Wrap(
                spacing: 12.w,
                runSpacing: 10.h,
                children: (option.values ?? []).map((val) {
                  final valId = val.id ?? 0;
                  final isSelected = selectedIds.contains(valId);
                  final extraPrice = val.extraPrice ?? 0;

                  return GestureDetector(
                    onTap: () => _handleSelect(option, val),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? context.mainColor
                            : context.isDarkMode
                                ? AppColors.white.withOpacity(0.05)
                                : AppColors.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: isSelected
                              ? context.mainColor
                              : context.isDarkMode
                                  ? Colors.white12
                                  : Colors.black.withOpacity(0.08),
                          width: 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: context.mainColor.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected) ...[
                            Icon(
                              option.allowMultiple ?? false
                                  ? Icons.check_box_rounded
                                  : Icons.radio_button_checked_rounded,
                              size: 16.sp,
                              color: context.isDarkMode ? AppColors.black : AppColors.white,
                            ),
                            SizedBox(width: 8.w),
                          ] else if (option.allowMultiple ?? false) ...[
                            Icon(
                              Icons.check_box_outline_blank_rounded,
                              size: 16.sp,
                              color: secondaryTextColor.withOpacity(0.6),
                            ),
                            SizedBox(width: 8.w),
                          ],
                          Text(
                            val.name ?? "",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                              color: isSelected
                                  ? (context.isDarkMode ? AppColors.black : AppColors.white)
                                  : textColor,
                            ),
                          ),
                          if (extraPrice > 0) ...[
                            SizedBox(width: 6.w),
                            Text(
                              "+$extraPrice EGP",
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
                                color: isSelected
                                    ? (context.isDarkMode ? AppColors.black : AppColors.white)
                                    : context.mainColor,
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
        );
      }).toList(),
    );
  }
}
