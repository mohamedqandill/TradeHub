import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/main_color.dart';

class ProductOptionWidget extends StatelessWidget {
  final String categoryAttName;
  final String value;

  const ProductOptionWidget({
    super.key,
    required this.categoryAttName,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.white.withOpacity(0.05)
            : AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.mainColor.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            categoryAttName.toUpperCase(),
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
              color: context.mainColor.withOpacity(0.6),
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: context.isDarkMode ? AppColors.white : AppColors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

//   // ================= MULTI =================
//   Widget _buildMulti() {
//     return Wrap(
//       spacing: 10.w,
//       runSpacing: 10.h,
//       children: widget.option.values.map((value) {
//         final isSelected = selectedMultiIds.contains(value.id);

//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               if (isSelected) {
//                 selectedMultiIds.remove(value.id);
//               } else {
//                 selectedMultiIds.add(value.id);
//               }
//             });

//             double total = 0;
//             for (var id in selectedMultiIds) {
//               total += widget.option.values.firstWhere((e) => e.id == id).price;
//             }

//             widget.onChanged(selectedMultiIds, total);
//           },
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? context.mainColor
//                   : context.isDarkMode
//                       ? AppColors.white.withOpacity(0.05)
//                       : AppColors.grey.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(
//                 color: isSelected
//                     ? context.mainColor
//                     : context.greyOrWhite.withOpacity(0.1),
//                 width: 1.5,
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isSelected) ...[
//                   Icon(
//                     Icons.check_circle,
//                     size: 16.sp,
//                     color:
//                         context.isDarkMode ? AppColors.black : AppColors.white,
//                   ),
//                   SizedBox(width: 8.w),
//                 ],
//                 Text(
//                   value.price > 0
//                       ? "${value.label} (+${value.price} EGP)"
//                       : value.label,
//                   style: context.base.theme.textTheme.bodyMedium?.copyWith(
//                     fontSize: 14.sp,
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                     color: isSelected
//                         ? (context.isDarkMode
//                             ? AppColors.black
//                             : AppColors.white)
//                         : context.greyOrWhite.withOpacity(0.7),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   // ================= COUNTER =================
//   Widget _buildCounter() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: context.isDarkMode
//             ? AppColors.white.withOpacity(0.05)
//             : AppColors.grey.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(30.r),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _buildCounterButton(
//             icon: Icons.remove,
//             onTap: () {
//               if (counterValue > 1) {
//                 setState(() => counterValue--);
//                 widget.onChanged(counterValue, 0);
//               }
//             },
//             color: context.isDarkMode
//                 ? AppColors.white.withOpacity(0.1)
//                 : AppColors.white,
//             iconColor: context.isDarkMode ? AppColors.white : AppColors.black,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Text(
//               counterValue.toString(),
//               style: context.base.theme.textTheme.bodyMedium?.copyWith(
//                 color: context.isDarkMode ? AppColors.white : AppColors.black,
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           _buildCounterButton(
//             icon: Icons.add,
//             onTap: () {
//               setState(() => counterValue++);
//               widget.onChanged(counterValue, 0);
//             },
//             color: context.mainColor,
//             iconColor: context.isDarkMode ? AppColors.black : AppColors.white,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCounterButton({
//     required IconData icon,
//     required VoidCallback onTap,
//     required Color color,
//     required Color iconColor,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(20.r),
//       child: Container(
//         width: 36.w,
//         height: 36.w,
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(
//           icon,
//           size: 20.sp,
//           color: iconColor,
//         ),
//       ),
//     );
//   }

//   // ================= TEXT =================
//   Widget _buildText() {
//     return TextField(
//       controller: textController,
//       maxLines: 2,
//       style: TextStyle(
//           fontSize: 14.sp,
//           color: context.isDarkMode ? AppColors.white : AppColors.black),
//       decoration: InputDecoration(
//         hintText: "Enter note...",
//         hintStyle: context.base.theme.textTheme.bodyMedium
//             ?.copyWith(color: AppColors.grey.withOpacity(0.6), fontSize: 13.sp),
//         filled: true,
//         fillColor: context.isDarkMode
//             ? AppColors.white.withOpacity(0.05)
//             : AppColors.grey.withOpacity(0.05),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(
//             color: context.greyOrWhite.withOpacity(0.1),
//             width: 1,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(
//             color: context.mainColor.withOpacity(0.5),
//             width: 1.5,
//           ),
//         ),
//         prefixIcon: Icon(
//           Icons.edit_note,
//           color: context.mainColor,
//         ),
//       ),
//       onChanged: (value) {
//         widget.onChanged(value, 0);
//       },
//     );
//   }

//   // ================= COLOR =================
//   Widget _buildColor() {
//     return Wrap(
//       spacing: 12.w,
//       runSpacing: 12.h,
//       children: widget.option.values.map((value) {
//         final isSelected = selectedSingleId == value.id;
//         final color = _hexToColor(value.hexColor ?? "#FFFFFF");

//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedSingleId = value.id;
//             });
//             widget.onChanged(value.id, value.price);
//           },
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             width: 44.w,
//             height: 44.w,
//             decoration: BoxDecoration(
//               color: color,
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: isSelected ? context.mainColor : Colors.transparent,
//                 width: 3.w,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: color.withOpacity(0.3),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: isSelected
//                 ? Center(
//                     child: Container(
//                       width: 12.w,
//                       height: 12.w,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 2,
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 : null,
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Color _hexToColor(String hex) {
//     hex = hex.replaceAll("#", "");
//     return Color(int.parse("FF$hex", radix: 16));
//   }
// }

// class OptionModel {
//   final int id;
//   final String name;
//   final String type; // single | multi | counter | text | color
//   final bool required;
//   final List<OptionValueModel> values;

//   OptionModel({
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.required,
//     required this.values,
//   });
// }

// class OptionValueModel {
//   final int id;
//   final String label;
//   final double price;
//   final String? hexColor; // for color type

//   OptionValueModel({
//     required this.id,
//     required this.label,
//     required this.price,
//     this.hexColor,
//   });
// }
