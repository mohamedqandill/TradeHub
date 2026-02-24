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
    Assets.images.imageT.path,
    Assets.images.imageT.path,
    Assets.images.imageT.path,
  ];

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
            height: 10.h,
          ),
          CarouselSlider(
              items: List.generate(
                items.length,
                (index) {
                  return Image.asset(
                    items[index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
              options: CarouselOptions(
                height: 250.h,
                aspectRatio: 1 / 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 15),
                autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {},
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wireless Headphone ",
                  style: context.base.theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.mainColor,
                      fontSize: 22.sp),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "550.0 EGP",
                      style: GoogleFonts.manrope(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: context.mainColor),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 58.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.black,
                                size: 17.sp,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "4.8",
                                style: context
                                    .base.theme.textTheme.headlineMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: context.mainColor,
                                        fontSize: 14.sp),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "120 Verified\n Reviwes",
                          style: context.base.theme.textTheme.bodyMedium
                              ?.copyWith(
                                  fontSize: 13.sp, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    title: Text(
                      "DESCRIPTION",
                      style: context.base.theme.textTheme.headlineMedium
                          ?.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: context.mainColor),
                    ),
                    iconColor:
                        context.isDarkMode ? AppColors.white : Colors.black,
                    collapsedIconColor: Colors.grey,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Text(
                            "This is a detailed product description. "
                            "It explains materials, size, quality, and other important details "
                            "that the customer needs to know before purchasing.",
                            style: context.base.theme.textTheme.bodyMedium
                                ?.copyWith(
                              fontSize: 13.sp,
                              color: context.greyOrWhite.withOpacity(0.8),
                            )),
                      ),
                    ],
                  ),
                )
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
