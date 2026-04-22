import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';
import 'package:tradehub/features/main_layout/home/data/models/responses/get_all_category_response.dart';

abstract class HomeLocalDataSource {
  Future<void> cacheCategories(List<GetAllCategoryResponse> categories);
  Future<List<GetAllCategoryResponse>?> getCachedCategories();
}

@Injectable(as: HomeLocalDataSource)
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String _cacheKey = 'CACHED_CATEGORIES';

  HomeLocalDataSourceImpl();

  @override
  Future<void> cacheCategories(List<GetAllCategoryResponse> categories) async {
    final List<String> jsonList =
        categories.map((cat) => jsonEncode(cat.toJson())).toList();
    await getIt<SharedPrefsHelper>().saveStringList(_cacheKey, jsonList);
  }

  @override
  Future<List<GetAllCategoryResponse>?> getCachedCategories() async {
    final List<String>? jsonList =
        getIt<SharedPrefsHelper>().getStringList(_cacheKey);
    if (jsonList != null && jsonList.isNotEmpty) {
      return jsonList
          .map(
              (jsonStr) => GetAllCategoryResponse.fromJson(jsonDecode(jsonStr)))
          .toList();
    }
    return null;
  }
}
