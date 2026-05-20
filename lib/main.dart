import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tradehub/core/api/api_constant/api_constant.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/routes/app_routes.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/shared_services/local_notifications_service';
import 'package:tradehub/core/shared_services/request_notification_service.dart';
import 'package:tradehub/core/shared_widgets/widgets/device_preview.dart';
import 'package:tradehub/core/theme/app_theme.dart';
import 'package:tradehub/core/utils/storage/hive_storage.dart';
import 'package:tradehub/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:tradehub/features/main_layout/cart/presentation/cubit/cart_cubit.dart';
import 'package:tradehub/features/main_layout/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:tradehub/features/main_layout/profile/presentation/cubit/profile_cubit.dart';
import 'package:tradehub/features/onBoarding/view_model/language_view_model.dart';
import 'package:tradehub/features/onBoarding/view_model/theme_view_model.dart';

import 'core/base/base_inherited_widgets.dart';
import 'core/utils/di/di.dart';
import 'core/utils/secure_storage/secure_storage_service.dart';
import 'core/utils/shared_prefs/prefs.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  await ScreenUtil.ensureScreenSize();
  await SharedPrefsHelper.init();
  LocalNotificationService.initialize();
  requestNotificationPermission();
  SharedPrefsHelper prefs = getIt<SharedPrefsHelper>();
  await HiveStorageHelper.init();
  final languageViewModel = getIt<LanguageViewModel>();
  await languageViewModel.loadLanguage();
  bool isFirstTime = prefs.getBool(AppConstants.firstTime) ?? true;
  String? token = await getIt<SecureStorageHelper>().read(ApiConstants.token);

  // if (token != null) {
  //   DioServiceExtension.updateDioWithToken(token);
  // }
  runApp(
    EasyLocalization(
      saveLocale: true,
      startLocale: const Locale(AppConstants.en),
      supportedLocales: const [
        Locale(AppConstants.en),
        Locale(AppConstants.ar)
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale(AppConstants.en),
      child: ChangeNotifierProvider(
        create: (context) => ThemeViewModel()..getSavedTheme(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<CartCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<FavouriteCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<ProfileCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<CheckoutCubit>(),
            ),
          ],
          
            child: MyApp(
              isFirstTime: isFirstTime,
              token: token,
            ),
          
        ),
      ),
    ),
  );
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstTime, required this.token});

  final bool isFirstTime;
  final String? token;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        var provider = Provider.of<ThemeViewModel>(context);

        return MaterialApp(
          navigatorObservers: [routeObserver],
          navigatorKey: navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'TradeHub',
          theme: AppTheme.getLightTheme(
              isArabic: context.locale.languageCode == AppConstants.ar),
          darkTheme: AppTheme.getDarkTheme(
              isArabic: context.locale.languageCode == AppConstants.ar),
          themeMode: provider.mode,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.getRoutes,
          initialRoute: isFirstTime
              ? Routes.splash
              : token != null
                  ? Routes.mainLayout
                  : Routes.login,
          builder: (context, child) {
            return BaseInheritedWidget(
              theme: provider.mode == ThemeMode.dark
                  ? AppTheme.getDarkTheme(
                      isArabic: context.locale.languageCode == AppConstants.ar)
                  : AppTheme.getLightTheme(
                      isArabic: context.locale.languageCode == AppConstants.ar),
              screenHeight: MediaQuery.sizeOf(context).height,
              screenWidth: MediaQuery.sizeOf(context).width,
              child: child!,
            );
          },
        );
      },
    );
  }
}

enum RequestStates { initial, error, success, loading }
//