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

import '../../../features/authentication/data/api/api_client.dart' as _i891;
import '../../../features/authentication/data/data_source_contract/login/login_data_source_contract.dart'
    as _i942;
import '../../../features/authentication/data/data_source_contract/register/register_data_source.dart'
    as _i91;
import '../../../features/authentication/data/data_source_impl/login/login_data_source_impl.dart'
    as _i573;
import '../../../features/authentication/data/data_source_impl/register/register_data_source_impl.dart'
    as _i788;
import '../../../features/authentication/data/repo_impl/login/login_repo_impl.dart'
    as _i199;
import '../../../features/authentication/data/repo_impl/register/register_repo_impl.dart'
    as _i651;
import '../../../features/authentication/domain/repo_contract/login/login_repo_contract.dart'
    as _i581;
import '../../../features/authentication/domain/repo_contract/register/register_repo.dart'
    as _i366;
import '../../../features/authentication/domain/use_cases/login/login_use_case.dart'
    as _i776;
import '../../../features/authentication/domain/use_cases/register/register_use_case.dart'
    as _i490;
import '../../../features/authentication/domain/use_cases/register/send_otp_use_case.dart'
    as _i501;
import '../../../features/authentication/domain/use_cases/register/verify_account_use_case.dart'
    as _i461;
import '../../../features/authentication/domain/use_cases/sign_with_facebook_use_case.dart'
    as _i261;
import '../../../features/authentication/domain/use_cases/sign_with_google_use_case.dart'
    as _i1003;
import '../../../features/authentication/presentation/forget%20password/bloc/forget_password_bloc.dart'
    as _i459;
import '../../../features/authentication/presentation/login/bloc/login_bloc.dart'
    as _i941;
import '../../../features/authentication/presentation/register/bloc/register_bloc.dart'
    as _i395;
import '../../../features/onBoarding/view_model/language_view_model.dart'
    as _i522;
import '../../../features/onBoarding/view_model/theme_view_model.dart' as _i364;
import '../dio/dio_services.dart' as _i825;
import '../secure_storage/secure_storage_service.dart' as _i611;
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
    gh.singleton<_i611.SecureStorageHelper>(() => _i611.SecureStorageHelper());
    gh.singleton<_i25.SharedPrefsHelper>(() => _i25.SharedPrefsHelper());
    gh.singleton<_i199.SessionManager>(() => _i199.SessionManager());
    gh.singleton<_i361.Dio>(
        () => dioServices.provideDio(gh<_i528.PrettyDioLogger>()));
    gh.factory<String>(
      () => dioServices.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.factory<_i891.AuthApiClient>(() => _i891.AuthApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseUrl'),
        ));
    gh.factory<_i942.LoginDataSourceContract>(
        () => _i573.LoginDataSourceImpl(gh<_i891.AuthApiClient>()));
    gh.factory<_i91.RegisterDataSource>(
        () => _i788.RegisterDataSourceImpl(gh<_i891.AuthApiClient>()));
    gh.factory<_i366.RegisterRepo>(
        () => _i651.RegisterRepoImpl(gh<_i91.RegisterDataSource>()));
    gh.factory<_i581.LoginRepoContract>(
        () => _i199.LoginRepoImpl(gh<_i942.LoginDataSourceContract>()));
    gh.factory<_i776.LoginUseCase>(
        () => _i776.LoginUseCase(gh<_i581.LoginRepoContract>()));
    gh.factory<_i490.RegisterUseCase>(
        () => _i490.RegisterUseCase(gh<_i366.RegisterRepo>()));
    gh.factory<_i501.SendOTPUseCase>(
        () => _i501.SendOTPUseCase(gh<_i366.RegisterRepo>()));
    gh.factory<_i461.VerifyAccountUseCase>(
        () => _i461.VerifyAccountUseCase(gh<_i366.RegisterRepo>()));
    gh.factory<_i261.SignWithFacebookUseCase>(
        () => _i261.SignWithFacebookUseCase(gh<_i366.RegisterRepo>()));
    gh.factory<_i1003.SignWithGoogleUseCase>(
        () => _i1003.SignWithGoogleUseCase(gh<_i366.RegisterRepo>()));
    gh.factory<_i941.LoginBloc>(() => _i941.LoginBloc(
          gh<_i776.LoginUseCase>(),
          gh<_i1003.SignWithGoogleUseCase>(),
          gh<_i261.SignWithFacebookUseCase>(),
        ));
    gh.factory<_i395.RegisterBloc>(() => _i395.RegisterBloc(
          gh<_i490.RegisterUseCase>(),
          gh<_i501.SendOTPUseCase>(),
          gh<_i461.VerifyAccountUseCase>(),
          gh<_i1003.SignWithGoogleUseCase>(),
          gh<_i261.SignWithFacebookUseCase>(),
        ));
    gh.factory<_i459.ForgetPasswordBloc>(
        () => _i459.ForgetPasswordBloc(gh<_i501.SendOTPUseCase>()));
    return this;
  }
}

class _$DioServices extends _i825.DioServices {}
