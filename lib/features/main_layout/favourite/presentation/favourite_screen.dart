import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_services/shared_product_repository.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/cubit/favourite_cubit.dart';

import 'favorites_screen_body.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    bool isFavoriteChange = getIt<SharedProductRepository>().isFavoriteChange;
    if (isFavoriteChange) {
      context.read<FavouriteCubit>().getFavorites();
      getIt<SharedProductRepository>().clearUpdates();
      getIt<SharedProductRepository>().clearFavoriteStateUpdate();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainLayoutAppBar(
        title: LocaleKeys.Favourite.tr(),
        enableLeading: true,
      ),
      // body: const EmptyFavoriteScreenBody(),
      body: const FavoritesScreenBody(),
    );
  }
}
