import 'package:flutter/material.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/category_details/presentation/category_details_args.dart';
import 'package:tradehub/features/category_details/presentation/cubit/category_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_details_screen_body.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final CategoryDetailsArgs args;
  const CategoryDetailsScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CategoryDetailsCubit>()..getCompaniesByCategory(args.categoryId),
      child: Scaffold(
        appBar: MainLayoutAppBar(
          title: args.categoryName,
          enableLeading: true,
        ),
        body: CategoryDetailsScreenBody(args: args),
      ),
    );
  }
}
