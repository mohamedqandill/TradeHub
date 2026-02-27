import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradehub/Core/colors/app_colors.dart';
import 'package:tradehub/Core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/main_color.dart';
import 'package:tradehub/features/product_details/presentation/widgets/product_options_widget.dart';

import '../../../core/assets/assets.gen.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({super.key});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  List<String> items = [
    Assets.images.foodA.path,
    Assets.images.foodB.path,
    Assets.images.foodA.path,
  ];
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<OptionModel> testOptions = [
      // 1️⃣ Single (Size)
      OptionModel(
        id: 1,
        name: "Size",
        type: "single",
        required: true,
        values: [
          OptionValueModel(id: 11, label: "Small", price: 0),
          OptionValueModel(id: 12, label: "Medium", price: 20),
          OptionValueModel(id: 13, label: "Large", price: 40),
        ],
      ),

      // 2️⃣ Multi (Extras)
      OptionModel(
        id: 2,
        name: "Extras",
        type: "multi",
        required: false,
        values: [
          OptionValueModel(id: 21, label: "Cheese", price: 10),
          OptionValueModel(id: 22, label: "Sauce", price: 5),
          OptionValueModel(id: 23, label: "Fries", price: 15),
        ],
      ),

      // 3️⃣ Counter (Quantity)
      OptionModel(
        id: 3,
        name: "Quantity",
        type: "counter",
        required: true,
        values: [],
      ),

      // 4️⃣ Text (Notes)
      OptionModel(
        id: 4,
        name: "Special Notes",
        type: "text",
        required: false,
        values: [],
      ),

      // 5️⃣ Color Selector
      OptionModel(
        id: 5,
        name: "Color",
        type: "color",
        required: true,
        values: [
          OptionValueModel(
            id: 51,
            label: "Red",
            price: 0,
            hexColor: "#FF0000",
          ),
          OptionValueModel(
            id: 52,
            label: "Blue",
            price: 10,
            hexColor: "#0000FF",
          ),
          OptionValueModel(
            id: 53,
            label: "Green",
            price: 5,
            hexColor: "#00FF00",
          ),
        ],
      ),
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.h,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: CarouselSlider(
                    items: List.generate(
                      items.length,
                      (index) {
                        return Hero(
                          tag: "product_image_$index",
                          child: Image.asset(
                            items[index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    options: CarouselOptions(
                      height: 280.h,
                      viewportFraction: 1.0,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 8),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      autoPlayCurve: Curves.easeInOutQuart,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: items.asMap().entries.map((entry) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentImageIndex == entry.key ? 24.w : 8.w,
                      height: 8.w,
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: _currentImageIndex == entry.key
                            ? context.mainColor
                            : AppColors.white.withOpacity(0.5),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "loaded rice bowl",
                  style: context.base.theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color:
                        context.isDarkMode ? AppColors.white : AppColors.black,
                    fontSize: 26.sp,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "180.0 EGP",
                          style: GoogleFonts.manrope(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w800,
                            color: context.mainColor,
                          ),
                        ),
                        Text(
                          "Tax included",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grey.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: context.mainColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: context.mainColor.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 20.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "4.8",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: context.mainColor,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "120 Reviews",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.only(bottom: 10.h),
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    title: Text(
                      "DESCRIPTION",
                      style:
                          context.base.theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: context.mainColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                    iconColor:
                        context.isDarkMode ? AppColors.white : Colors.black,
                    collapsedIconColor: AppColors.grey,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Text(
                          "This is a detailed product description. "
                          "It explains materials, size, quality, and other important details "
                          "that the customer needs to know before purchasing.",
                          style:
                              context.base.theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            color: context.greyOrWhite.withOpacity(0.7),
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...testOptions.map(
            (option) {
              return ProductOptionWidget(
                option: option,
                onChanged: (value, price) {
                  setState(() {});
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
