// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cookie_jar/cookie_jar.dart' as _i557;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../../features/authentication/data/api/api_client.dart' as _i891;
import '../../../features/authentication/data/data_source_contract/login/login_data_source_contract.dart'
    as _i942;
import '../../../features/authentication/data/data_source_contract/new_password/new_password_data_source_contract.dart'
    as _i276;
import '../../../features/authentication/data/data_source_contract/register/register_data_source.dart'
    as _i91;
import '../../../features/authentication/data/data_source_contract/verify_otp/verify_otp_data_source_contract.dart'
    as _i994;
import '../../../features/authentication/data/data_source_impl/login/login_data_source_impl.dart'
    as _i573;
import '../../../features/authentication/data/data_source_impl/new_password/new_password_data_source_impl.dart'
    as _i336;
import '../../../features/authentication/data/data_source_impl/register/register_data_source_impl.dart'
    as _i788;
import '../../../features/authentication/data/data_source_impl/verify_otp/verify_otp_data_source_impl.dart'
    as _i232;
import '../../../features/authentication/data/repo_impl/login/login_repo_impl.dart'
    as _i199;
import '../../../features/authentication/data/repo_impl/new_password/new_password_repo_impl.dart'
    as _i972;
import '../../../features/authentication/data/repo_impl/register/register_repo_impl.dart'
    as _i651;
import '../../../features/authentication/data/repo_impl/verify_otp/verify_otp_repo_impl.dart'
    as _i364;
import '../../../features/authentication/domain/repo_contract/login/login_repo_contract.dart'
    as _i581;
import '../../../features/authentication/domain/repo_contract/new_password/new_password_repo_contract.dart'
    as _i917;
import '../../../features/authentication/domain/repo_contract/register/register_repo.dart'
    as _i366;
import '../../../features/authentication/domain/repo_contract/verify_otp/verify_otp_repo_contract.dart'
    as _i95;
import '../../../features/authentication/domain/use_cases/login/login_use_case.dart'
    as _i776;
import '../../../features/authentication/domain/use_cases/new_password/new_password_use_case.dart'
    as _i747;
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
import '../../../features/authentication/domain/use_cases/verify_otp/verify_otp_use_case.dart'
    as _i550;
import '../../../features/authentication/presentation/forget%20password/bloc/forget_password_bloc.dart'
    as _i459;
import '../../../features/authentication/presentation/login/bloc/login_bloc.dart'
    as _i941;
import '../../../features/authentication/presentation/new%20password/bloc/new_password_bloc.dart'
    as _i689;
import '../../../features/authentication/presentation/register/bloc/register_bloc.dart'
    as _i395;
import '../../../features/authentication/presentation/verify%20email/bloc/verify_otp_bloc.dart'
    as _i429;
import '../../../features/main_layout/cart/data/api/cart_api_client.dart'
    as _i790;
import '../../../features/main_layout/cart/data/data_source/cart_data_source_contract.dart'
    as _i793;
import '../../../features/main_layout/cart/data/data_source/cart_data_source_impl.dart'
    as _i155;
import '../../../features/main_layout/cart/data/repo_impl/cart_repo_impl.dart'
    as _i149;
import '../../../features/main_layout/cart/domain/repo_contract/cart_repo_contract.dart'
    as _i232;
import '../../../features/main_layout/cart/domain/use_case/get_basket_usecase.dart'
    as _i255;
import '../../../features/main_layout/cart/domain/use_case/remove_basket_usecase.dart'
    as _i826;
import '../../../features/main_layout/cart/domain/use_case/remove_item_usecase.dart'
    as _i346;
import '../../../features/main_layout/cart/domain/use_case/update_item_quantity_usecase.dart'
    as _i922;
import '../../../features/main_layout/cart/presentation/cubit/cart_cubit.dart'
    as _i720;
import '../../../features/main_layout/favourite/data/api/favourite_api_client.dart'
    as _i54;
import '../../../features/main_layout/favourite/data/data_source/favourite_data_source.dart'
    as _i768;
import '../../../features/main_layout/favourite/data/repo_impl/favourite_repo_impl.dart'
    as _i951;
import '../../../features/main_layout/favourite/domain/repos_contract/favourite_repo_contract.dart'
    as _i959;
import '../../../features/main_layout/favourite/domain/use_cases/get_favorites_use_case.dart'
    as _i467;
import '../../../features/main_layout/favourite/domain/use_cases/toggle_favorite_use_case.dart'
    as _i1057;
import '../../../features/main_layout/favourite/presentation/cubit/favourite_cubit.dart'
    as _i639;
import '../../../features/main_layout/home/data/api/home_api_client.dart'
    as _i804;
import '../../../features/main_layout/home/data/data_source/home_data_source.dart'
    as _i529;
import '../../../features/main_layout/home/data/data_source/home_local_data_source.dart'
    as _i595;
import '../../../features/main_layout/home/data/repo_impl/home_repo_impl.dart'
    as _i359;
import '../../../features/main_layout/home/domain/repos_contract/home_repo_contract.dart'
    as _i382;
import '../../../features/main_layout/home/domain/use_cases/get_all_category_usecase.dart'
    as _i894;
import '../../../features/main_layout/home/domain/use_cases/get_all_companies_usecase.dart'
    as _i48;
import '../../../features/main_layout/home/domain/use_cases/get_random_products_usecase.dart'
    as _i231;
import '../../../features/main_layout/home/presentation/cubit/home_cubit.dart'
    as _i167;
import '../../../features/onBoarding/view_model/language_view_model.dart'
    as _i522;
import '../../../features/onBoarding/view_model/theme_view_model.dart' as _i364;
import '../../../features/product_details/data/api/product_details_api_client.dart'
    as _i1050;
import '../../../features/product_details/data/data_source_contract/product_details_data_source_contract.dart'
    as _i463;
import '../../../features/product_details/data/data_source_impl/product_details_data_source_impl.dart'
    as _i888;
import '../../../features/product_details/data/repo_impl/product_details_repository_impl.dart'
    as _i1002;
import '../../../features/product_details/domain/repo_contract/product_details_repository_contract.dart'
    as _i1070;
import '../../../features/product_details/domain/use_cases/add_to_cart_usecase.dart'
    as _i875;
import '../../../features/product_details/domain/use_cases/get_product_details_usecase.dart'
    as _i631;
import '../../../features/product_details/presentation/cubit/product_details_cubit.dart'
    as _i39;
import '../dio/dio_services.dart' as _i825;
import '../secure_storage/secure_storage_service.dart' as _i611;
import '../shared_prefs/prefs.dart' as _i25;
import '../storage/hive_storage.dart' as _i799;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioServices = _$DioServices();
    gh.factory<_i522.LanguageViewModel>(() => _i522.LanguageViewModel());
    gh.factory<_i364.ThemeViewModel>(() => _i364.ThemeViewModel());
    gh.singleton<_i528.PrettyDioLogger>(() => dioServices.provideDioLogger());
    await gh.singletonAsync<_i557.CookieJar>(
      () => dioServices.provideCookieJar(),
      preResolve: true,
    );
    gh.singleton<_i611.SecureStorageHelper>(() => _i611.SecureStorageHelper());
    gh.singleton<_i25.SharedPrefsHelper>(() => _i25.SharedPrefsHelper());
    gh.singleton<_i799.HiveStorageHelper>(() => _i799.HiveStorageHelper());
    gh.singleton<_i199.SessionManager>(() => _i199.SessionManager());
    gh.factory<_i595.HomeLocalDataSource>(
        () => _i595.HomeLocalDataSourceImpl());
    gh.factory<String>(
      () => dioServices.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.singleton<_i361.Dio>(() => dioServices.provideDio(
          gh<_i528.PrettyDioLogger>(),
          gh<_i557.CookieJar>(),
        ));
    gh.factory<_i891.AuthApiClient>(() => _i891.AuthApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseUrl'),
        ));
    gh.singleton<_i790.CartApiClient>(() => _i790.CartApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseUrl'),
        ));
    gh.singleton<_i804.HomeApiClient>(() => _i804.HomeApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseUrl'),
        ));
    gh.singleton<_i1050.ProductDetailsApiClient>(
        () => _i1050.ProductDetailsApiClient(
              gh<_i361.Dio>(),
              baseUrl: gh<String>(instanceName: 'baseUrl'),
            ));
    gh.singleton<_i54.FavouriteApiClient>(() => _i54.FavouriteApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseUrl'),
        ));
    gh.factory<_i768.FavouriteDataSource>(
        () => _i768.FavouriteDataSourceImpl(gh<_i54.FavouriteApiClient>()));
    gh.factory<_i276.NewPasswordDataSourceContract>(
        () => _i336.NewPasswordDataSourceImpl(gh<_i891.AuthApiClient>()));
    gh.factory<_i959.FavouriteRepoContract>(
        () => _i951.FavouriteRepoImpl(gh<_i768.FavouriteDataSource>()));
    gh.factory<_i942.LoginDataSourceContract>(
        () => _i573.LoginDataSourceImpl(gh<_i891.AuthApiClient>()));
    gh.factory<_i529.HomeDataSource>(
        () => _i529.HomeDataSourceImpl(gh<_i804.HomeApiClient>()));
    gh.factory<_i91.RegisterDataSource>(
        () => _i788.RegisterDataSourceImpl(gh<_i891.AuthApiClient>()));
    gh.factory<_i994.VerifyOTPDataSourceContract>(
        () => _i232.VerifyOTPDataSourceImpl(gh<_i891.AuthApiClient>()));
    gh.factory<_i366.RegisterRepo>(
        () => _i651.RegisterRepoImpl(gh<_i91.RegisterDataSource>()));
    gh.factory<_i463.ProductDetailsDataSourceContract>(() =>
        _i888.ProductDetailsDataSourceImpl(
            gh<_i1050.ProductDetailsApiClient>()));
    gh.factory<_i382.HomeRepoContract>(() => _i359.HomeRepoImpl(
          gh<_i529.HomeDataSource>(),
          gh<_i595.HomeLocalDataSource>(),
        ));
    gh.factory<_i467.GetFavoritesUseCase>(
        () => _i467.GetFavoritesUseCase(gh<_i959.FavouriteRepoContract>()));
    gh.factory<_i1057.ToggleFavoriteUseCase>(
        () => _i1057.ToggleFavoriteUseCase(gh<_i959.FavouriteRepoContract>()));
    gh.factory<_i793.CartDataSourceContract>(
        () => _i155.CartDataSourceImpl(gh<_i790.CartApiClient>()));
    gh.factory<_i95.VerifyOTPRepoContract>(
        () => _i364.VerifyOTPRepoImpl(gh<_i994.VerifyOTPDataSourceContract>()));
    gh.factory<_i917.NewPasswordRepoContract>(() =>
        _i972.NewPasswordRepoImpl(gh<_i276.NewPasswordDataSourceContract>()));
    gh.factory<_i232.CartRepoContract>(
        () => _i149.CartRepoImpl(gh<_i793.CartDataSourceContract>()));
    gh.factory<_i581.LoginRepoContract>(
        () => _i199.LoginRepoImpl(gh<_i942.LoginDataSourceContract>()));
    gh.factory<_i1070.ProductDetailsRepositoryContract>(() =>
        _i1002.ProductDetailsRepositoryImpl(
            gh<_i463.ProductDetailsDataSourceContract>()));
    gh.factory<_i894.GetAllCategoryUseCase>(
        () => _i894.GetAllCategoryUseCase(gh<_i382.HomeRepoContract>()));
    gh.factory<_i48.GetAllCompaniesUseCase>(
        () => _i48.GetAllCompaniesUseCase(gh<_i382.HomeRepoContract>()));
    gh.factory<_i231.GetRandomProductsUseCase>(
        () => _i231.GetRandomProductsUseCase(gh<_i382.HomeRepoContract>()));
    gh.factory<_i255.GetBasketUseCase>(
        () => _i255.GetBasketUseCase(gh<_i232.CartRepoContract>()));
    gh.factory<_i826.RemoveBasketUseCase>(
        () => _i826.RemoveBasketUseCase(gh<_i232.CartRepoContract>()));
    gh.factory<_i346.RemoveItemUseCase>(
        () => _i346.RemoveItemUseCase(gh<_i232.CartRepoContract>()));
    gh.factory<_i922.UpdateItemQuantityUseCase>(
        () => _i922.UpdateItemQuantityUseCase(gh<_i232.CartRepoContract>()));
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
    gh.factory<_i639.FavouriteCubit>(() => _i639.FavouriteCubit(
          gh<_i467.GetFavoritesUseCase>(),
          gh<_i1057.ToggleFavoriteUseCase>(),
        ));
    gh.factory<_i167.HomeCubit>(() => _i167.HomeCubit(
          gh<_i894.GetAllCategoryUseCase>(),
          gh<_i48.GetAllCompaniesUseCase>(),
          gh<_i231.GetRandomProductsUseCase>(),
        ));
    gh.factory<_i550.VerifyOTPUseCase>(
        () => _i550.VerifyOTPUseCase(gh<_i95.VerifyOTPRepoContract>()));
    gh.factory<_i747.NewPasswordUseCase>(
        () => _i747.NewPasswordUseCase(gh<_i917.NewPasswordRepoContract>()));
    gh.factory<_i941.LoginBloc>(() => _i941.LoginBloc(
          gh<_i776.LoginUseCase>(),
          gh<_i1003.SignWithGoogleUseCase>(),
          gh<_i261.SignWithFacebookUseCase>(),
        ));
    gh.factory<_i875.AddToCartUseCase>(() =>
        _i875.AddToCartUseCase(gh<_i1070.ProductDetailsRepositoryContract>()));
    gh.factory<_i631.GetProductDetailsUseCase>(() =>
        _i631.GetProductDetailsUseCase(
            gh<_i1070.ProductDetailsRepositoryContract>()));
    gh.factory<_i395.RegisterBloc>(() => _i395.RegisterBloc(
          gh<_i490.RegisterUseCase>(),
          gh<_i501.SendOTPUseCase>(),
          gh<_i461.VerifyAccountUseCase>(),
          gh<_i1003.SignWithGoogleUseCase>(),
          gh<_i261.SignWithFacebookUseCase>(),
        ));
    gh.factory<_i459.ForgetPasswordBloc>(
        () => _i459.ForgetPasswordBloc(gh<_i501.SendOTPUseCase>()));
    gh.factory<_i720.CartCubit>(() => _i720.CartCubit(
          gh<_i255.GetBasketUseCase>(),
          gh<_i875.AddToCartUseCase>(),
          gh<_i826.RemoveBasketUseCase>(),
          gh<_i346.RemoveItemUseCase>(),
          gh<_i922.UpdateItemQuantityUseCase>(),
        ));
    gh.factory<_i689.NewPasswordBloc>(
        () => _i689.NewPasswordBloc(gh<_i747.NewPasswordUseCase>()));
    gh.factory<_i429.VerifyOtpBloc>(
        () => _i429.VerifyOtpBloc(gh<_i550.VerifyOTPUseCase>()));
    gh.factory<_i39.ProductDetailsCubit>(() => _i39.ProductDetailsCubit(
          gh<_i631.GetProductDetailsUseCase>(),
          gh<_i875.AddToCartUseCase>(),
          gh<_i1057.ToggleFavoriteUseCase>(),
        ));
    return this;
  }
}

class _$DioServices extends _i825.DioServices {}
