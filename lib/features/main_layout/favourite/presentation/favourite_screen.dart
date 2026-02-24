import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';

import 'favorites_screen_body.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MainLayoutAppBar(title: LocaleKeys.Favourite.tr()),
        // body: const EmptyFavoriteScreenBody(),
        body: const FavoritesScreenBody(),
      ),
    );
  }
}
