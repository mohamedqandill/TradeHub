import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/routes/app_routes.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/theme/app_theme.dart';
import 'package:tradehub/features/onBoarding/view_model/language_view_model.dart';
import 'package:tradehub/features/onBoarding/view_model/theme_view_model.dart';

import 'core/base/base_inherited_widgets.dart';
import 'core/utils/di/di.dart';
import 'core/utils/shared_prefs/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();
  await ScreenUtil.ensureScreenSize();
  await SharedPrefsHelper.init();
  SharedPrefsHelper prefs = getIt<SharedPrefsHelper>();
  final languageViewModel = getIt<LanguageViewModel>();
  await languageViewModel.loadLanguage();
  bool? isFirstTime = prefs.getBool(AppConstants.firstTime);
  runApp(EasyLocalization(
    saveLocale: true,
    startLocale: const Locale(AppConstants.en),
    supportedLocales: const [Locale(AppConstants.en), Locale(AppConstants.ar)],
    path: 'assets/translations', // <-- change the path of the translation files
    fallbackLocale: const Locale(AppConstants.en, AppConstants.us),
    child: ChangeNotifierProvider(
      create: (context) => ThemeViewModel()..getSavedTheme(),
      child: MyApp(
        isTrue: isFirstTime ?? true,
      ),
    ),
  ));
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isTrue});

  final bool isTrue;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        var provider = Provider.of<ThemeViewModel>(context);

        return BaseInheritedWidget(
          theme: provider.mode == ThemeMode.dark
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
          screenHeight: MediaQuery.of(context).size.height,
          screenWidth: MediaQuery.of(context).size.width,
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: provider.mode,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.getRoutes,
            initialRoute: isTrue ? Routes.splash : Routes.splash,
          ),
        );
      },
    );
  }
}
