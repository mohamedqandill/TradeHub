// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../../features/onBoarding/view_model/language_view_model.dart'
    as _i522;
import '../../../features/onBoarding/view_model/theme_view_model.dart' as _i364;
import '../dio/dio_services.dart' as _i825;
import '../shared_prefs/prefs.dart' as _i25;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioServices = _$DioServices();
    gh.factory<_i522.LanguageViewModel>(() => _i522.LanguageViewModel());
    gh.factory<_i364.ThemeViewModel>(() => _i364.ThemeViewModel());
    gh.singleton<_i528.PrettyDioLogger>(() => dioServices.provideDioLogger());
    gh.singleton<_i25.SharedPrefsHelper>(() => _i25.SharedPrefsHelper());
    gh.singleton<_i361.Dio>(
        () => dioServices.provideDio(gh<_i528.PrettyDioLogger>()));
    gh.factory<String>(
      () => dioServices.baseUrl,
      instanceName: 'baseUrl',
    );
    return this;
  }
}

class _$DioServices extends _i825.DioServices {}
