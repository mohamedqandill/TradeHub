import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main_layout/home/presentation/widgets/products_section.dart';

class ProductSectionWidget extends StatelessWidget {
  const ProductSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: const ProductsSection(),
      ),
    );
  }
}
