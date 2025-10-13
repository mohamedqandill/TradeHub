import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/routes/app_routes.dart';
import 'package:tradehub/core/routes/routes.dart';
import 'package:tradehub/core/theme/app_theme.dart';

import 'core/base/base_inherited_widgets.dart';
import 'core/utils/shared_prefs/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();
  SharedPrefsHelper prefs = SharedPrefsHelper();
  bool? isFirstTime = prefs.getBool(AppConstants.firstTime);
  runApp(MyApp(
    isTrue: isFirstTime ?? true,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isTrue});
  final bool isTrue;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => BaseInheritedWidget(
        theme: AppTheme.lightTheme,
        screenHeight: MediaQuery.of(context).size.height,
        screenWidth: MediaQuery.of(context).size.width,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.getRoutes,
          initialRoute: isTrue ? Routes.splash : Routes.splash,
        ),
      ),
    );
  }
}

///
