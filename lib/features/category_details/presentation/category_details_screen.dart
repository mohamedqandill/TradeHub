import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'category_details_screen_body.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainLayoutAppBar(
        title: LocaleKeys.categoryVendors.tr(),
        enableLeading: true,
      ),
      body: const CategoryDetailsScreenBody(),
    );
  }
}
