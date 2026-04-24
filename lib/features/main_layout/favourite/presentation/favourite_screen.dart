import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/cubit/favourite_cubit.dart';

import 'favorites_screen_body.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FavouriteCubit>()..getFavorites(),
      child: Scaffold(
        appBar: MainLayoutAppBar(
          title: LocaleKeys.Favourite.tr(),
          enableLeading: true,
        ),
        // body: const EmptyFavoriteScreenBody(),
        body: const FavoritesScreenBody(),
      ),
    );
  }
}
