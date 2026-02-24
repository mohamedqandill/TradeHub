import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

import '../../../../core/constants/app_constants.dart';

class ProductOptionWidget extends StatefulWidget {
  final OptionModel option;
  final Function(dynamic value, double price) onChanged;

  const ProductOptionWidget({
    super.key,
    required this.option,
    required this.onChanged,
  });

  @override
  State<ProductOptionWidget> createState() => _ProductOptionWidgetState();
}

class _ProductOptionWidgetState extends State<ProductOptionWidget> {
  int? selectedSingleId;
  List<int> selectedMultiIds = [];
  int counterValue = 1;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: context.isDarkMode ? AppColors.black : AppColors.white,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.option.name}${widget.option.required ? " *" : ""}",
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: context.greyOrWhite),
            ),
            SizedBox(height: 10.h),
            _buildByType(),
          ],
        ),
      ),
    );
  }

  Widget _buildByType() {
    switch (widget.option.type) {
      case "single":
        return _buildSingle();
      case "multi":
        return _buildMulti();
      case "counter":
        return _buildCounter();
      case "text":
        return _buildText();
      case "color":
        return _buildColor();
      default:
        return const SizedBox();
    }
  }

  // ================= SINGLE =================
  Widget _buildSingle() {
    return Wrap(
      spacing: 8,
      children: widget.option.values.map((value) {
        return ChoiceChip(
          selectedColor: context.mainColor,
          checkmarkColor:
              context.isDarkMode ? AppColors.black : AppColors.white,
          label: Text(
            "${value.label} (+${value.price} EGP)",
            style: context.base.theme.textTheme.bodyMedium?.copyWith(
                fontSize: 13.sp,
                color: selectedSingleId == value.id
                    ? context.isDarkMode
                        ? AppColors.black
                        : AppColors.white
                    : AppColors.grey),
          ),
          selected: selectedSingleId == value.id,
          onSelected: (_) {
            setState(() {
              selectedSingleId = value.id;
            });
            widget.onChanged(value.id, value.price);
          },
        );
      }).toList(),
    );
  }

  // ================= MULTI =================
  Widget _buildMulti() {
    return Wrap(
      spacing: 8,
      children: widget.option.values.map((value) {
        final isSelected = selectedMultiIds.contains(value.id);

        return FilterChip(
          selectedColor: context.mainColor,
          checkmarkColor:
              context.isDarkMode ? AppColors.black : AppColors.white,
          label: Text(
            "${value.label} (+${value.price} EGP)",
            style: context.base.theme.textTheme.bodyMedium?.copyWith(
                fontSize: 13.sp,
                color: selectedSingleId == value.id
                    ? context.isDarkMode
                        ? AppColors.black
                        : AppColors.white
                    : AppColors.grey),
          ),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                selectedMultiIds.add(value.id);
              } else {
                selectedMultiIds.remove(value.id);
              }
            });

            double total = 0;
            for (var id in selectedMultiIds) {
              total += widget.option.values.firstWhere((e) => e.id == id).price;
            }

            widget.onChanged(selectedMultiIds, total);
          },
        );
      }).toList(),
    );
  }

  // ================= COUNTER =================
  Widget _buildCounter() {
    return Padding(
      padding: context.locale.languageCode == AppConstants.ar
          ? EdgeInsets.only(left: 10.w)
          : EdgeInsets.only(right: 10.w),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (counterValue > 1) {
                setState(() => counterValue--);
                widget.onChanged(counterValue, 0);
              }
            },
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                      color: AppColors.grey.withOpacity(0.5), width: 1),
                  shape: BoxShape.circle),
              child: Icon(
                Icons.remove,
                size: 17.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              counterValue.toString(),
              style: context.base.theme.textTheme.bodyMedium?.copyWith(
                  color: context.isDarkMode ? AppColors.white : AppColors.black,
                  fontSize: 15.sp),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() => counterValue++);
              widget.onChanged(counterValue, 0);
            },
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                  color: context.mainColor, shape: BoxShape.circle),
              child: Icon(
                Icons.add,
                size: 17.sp,
                color: context.isDarkMode ? AppColors.black : AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= TEXT =================
  Widget _buildText() {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
          hintText: "Enter note...",
          hintStyle: context.base.theme.textTheme.bodyMedium
              ?.copyWith(color: AppColors.grey)),
      onChanged: (value) {
        widget.onChanged(value, 0);
      },
    );
  }

  // ================= COLOR =================
  Widget _buildColor() {
    return Wrap(
      spacing: 10,
      children: widget.option.values.map((value) {
        final isSelected = selectedSingleId == value.id;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedSingleId = value.id;
            });
            widget.onChanged(value.id, value.price);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _hexToColor(value.hexColor ?? "#FFFFFF"),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey,
                width: 2,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    return Color(int.parse("FF$hex", radix: 16));
  }
}

class OptionModel {
  final int id;
  final String name;
  final String type; // single | multi | counter | text | color
  final bool required;
  final List<OptionValueModel> values;

  OptionModel({
    required this.id,
    required this.name,
    required this.type,
    required this.required,
    required this.values,
  });
}

class OptionValueModel {
  final int id;
  final String label;
  final double price;
  final String? hexColor; // for color type

  OptionValueModel({
    required this.id,
    required this.label,
    required this.price,
    this.hexColor,
  });
}
