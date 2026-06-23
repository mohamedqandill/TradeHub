// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  RequestStates get getCategoryState => throw _privateConstructorUsedError;
  RequestStates get getCompaniesState => throw _privateConstructorUsedError;
  RequestStates get getRandomProductsState =>
      throw _privateConstructorUsedError;
  RequestStates get searchProductsState => throw _privateConstructorUsedError;
  List<GetRandomProductEntity> get randomProducts =>
      throw _privateConstructorUsedError;
  List<GetRandomProductEntity> get searchProducts =>
      throw _privateConstructorUsedError;
  int get productsPageIndex => throw _privateConstructorUsedError;
  bool get productsHasReachedMax => throw _privateConstructorUsedError;
  bool get isFetchingMoreProducts => throw _privateConstructorUsedError;
  String? get productsSort => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RequestStates getCategoryState,
            RequestStates getCompaniesState,
            RequestStates getRandomProductsState,
            RequestStates searchProductsState,
            List<GetRandomProductEntity> randomProducts,
            List<GetRandomProductEntity> searchProducts,
            int productsPageIndex,
            bool productsHasReachedMax,
            bool isFetchingMoreProducts,
            String? productsSort,
            String? errorMessage)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RequestStates getCategoryState,
            RequestStates getCompaniesState,
            RequestStates getRandomProductsState,
            RequestStates searchProductsState,
            List<GetRandomProductEntity> randomProducts,
            List<GetRandomProductEntity> searchProducts,
            int productsPageIndex,
            bool productsHasReachedMax,
            bool isFetchingMoreProducts,
            String? productsSort,
            String? errorMessage)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RequestStates getCategoryState,
            RequestStates getCompaniesState,
            RequestStates getRandomProductsState,
            RequestStates searchProductsState,
            List<GetRandomProductEntity> randomProducts,
            List<GetRandomProductEntity> searchProducts,
            int productsPageIndex,
            bool productsHasReachedMax,
            bool isFetchingMoreProducts,
            String? productsSort,
            String? errorMessage)?
        initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {RequestStates getCategoryState,
      RequestStates getCompaniesState,
      RequestStates getRandomProductsState,
      RequestStates searchProductsState,
      List<GetRandomProductEntity> randomProducts,
      List<GetRandomProductEntity> searchProducts,
      int productsPageIndex,
      bool productsHasReachedMax,
      bool isFetchingMoreProducts,
      String? productsSort,
      String? errorMessage});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? getCategoryState = null,
    Object? getCompaniesState = null,
    Object? getRandomProductsState = null,
    Object? searchProductsState = null,
    Object? randomProducts = null,
    Object? searchProducts = null,
    Object? productsPageIndex = null,
    Object? productsHasReachedMax = null,
    Object? isFetchingMoreProducts = null,
    Object? productsSort = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      getCategoryState: null == getCategoryState
          ? _value.getCategoryState
          : getCategoryState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      getCompaniesState: null == getCompaniesState
          ? _value.getCompaniesState
          : getCompaniesState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      getRandomProductsState: null == getRandomProductsState
          ? _value.getRandomProductsState
          : getRandomProductsState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      searchProductsState: null == searchProductsState
          ? _value.searchProductsState
          : searchProductsState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      randomProducts: null == randomProducts
          ? _value.randomProducts
          : randomProducts // ignore: cast_nullable_to_non_nullable
              as List<GetRandomProductEntity>,
      searchProducts: null == searchProducts
          ? _value.searchProducts
          : searchProducts // ignore: cast_nullable_to_non_nullable
              as List<GetRandomProductEntity>,
      productsPageIndex: null == productsPageIndex
          ? _value.productsPageIndex
          : productsPageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      productsHasReachedMax: null == productsHasReachedMax
          ? _value.productsHasReachedMax
          : productsHasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingMoreProducts: null == isFetchingMoreProducts
          ? _value.isFetchingMoreProducts
          : isFetchingMoreProducts // ignore: cast_nullable_to_non_nullable
              as bool,
      productsSort: freezed == productsSort
          ? _value.productsSort
          : productsSort // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RequestStates getCategoryState,
      RequestStates getCompaniesState,
      RequestStates getRandomProductsState,
      RequestStates searchProductsState,
      List<GetRandomProductEntity> randomProducts,
      List<GetRandomProductEntity> searchProducts,
      int productsPageIndex,
      bool productsHasReachedMax,
      bool isFetchingMoreProducts,
      String? productsSort,
      String? errorMessage});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? getCategoryState = null,
    Object? getCompaniesState = null,
    Object? getRandomProductsState = null,
    Object? searchProductsState = null,
    Object? randomProducts = null,
    Object? searchProducts = null,
    Object? productsPageIndex = null,
    Object? productsHasReachedMax = null,
    Object? isFetchingMoreProducts = null,
    Object? productsSort = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$InitialImpl(
      getCategoryState: null == getCategoryState
          ? _value.getCategoryState
          : getCategoryState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      getCompaniesState: null == getCompaniesState
          ? _value.getCompaniesState
          : getCompaniesState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      getRandomProductsState: null == getRandomProductsState
          ? _value.getRandomProductsState
          : getRandomProductsState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      searchProductsState: null == searchProductsState
          ? _value.searchProductsState
          : searchProductsState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      randomProducts: null == randomProducts
          ? _value._randomProducts
          : randomProducts // ignore: cast_nullable_to_non_nullable
              as List<GetRandomProductEntity>,
      searchProducts: null == searchProducts
          ? _value._searchProducts
          : searchProducts // ignore: cast_nullable_to_non_nullable
              as List<GetRandomProductEntity>,
      productsPageIndex: null == productsPageIndex
          ? _value.productsPageIndex
          : productsPageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      productsHasReachedMax: null == productsHasReachedMax
          ? _value.productsHasReachedMax
          : productsHasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingMoreProducts: null == isFetchingMoreProducts
          ? _value.isFetchingMoreProducts
          : isFetchingMoreProducts // ignore: cast_nullable_to_non_nullable
              as bool,
      productsSort: freezed == productsSort
          ? _value.productsSort
          : productsSort // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.getCategoryState = RequestStates.initial,
      this.getCompaniesState = RequestStates.initial,
      this.getRandomProductsState = RequestStates.initial,
      this.searchProductsState = RequestStates.initial,
      final List<GetRandomProductEntity> randomProducts = const [],
      final List<GetRandomProductEntity> searchProducts = const [],
      this.productsPageIndex = 1,
      this.productsHasReachedMax = false,
      this.isFetchingMoreProducts = false,
      this.productsSort,
      this.errorMessage})
      : _randomProducts = randomProducts,
        _searchProducts = searchProducts;

  @override
  @JsonKey()
  final RequestStates getCategoryState;
  @override
  @JsonKey()
  final RequestStates getCompaniesState;
  @override
  @JsonKey()
  final RequestStates getRandomProductsState;
  @override
  @JsonKey()
  final RequestStates searchProductsState;
  final List<GetRandomProductEntity> _randomProducts;
  @override
  @JsonKey()
  List<GetRandomProductEntity> get randomProducts {
    if (_randomProducts is EqualUnmodifiableListView) return _randomProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_randomProducts);
  }

  final List<GetRandomProductEntity> _searchProducts;
  @override
  @JsonKey()
  List<GetRandomProductEntity> get searchProducts {
    if (_searchProducts is EqualUnmodifiableListView) return _searchProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchProducts);
  }

  @override
  @JsonKey()
  final int productsPageIndex;
  @override
  @JsonKey()
  final bool productsHasReachedMax;
  @override
  @JsonKey()
  final bool isFetchingMoreProducts;
  @override
  final String? productsSort;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'HomeState.initial(getCategoryState: $getCategoryState, getCompaniesState: $getCompaniesState, getRandomProductsState: $getRandomProductsState, searchProductsState: $searchProductsState, randomProducts: $randomProducts, searchProducts: $searchProducts, productsPageIndex: $productsPageIndex, productsHasReachedMax: $productsHasReachedMax, isFetchingMoreProducts: $isFetchingMoreProducts, productsSort: $productsSort, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.getCategoryState, getCategoryState) ||
                other.getCategoryState == getCategoryState) &&
            (identical(other.getCompaniesState, getCompaniesState) ||
                other.getCompaniesState == getCompaniesState) &&
            (identical(other.getRandomProductsState, getRandomProductsState) ||
                other.getRandomProductsState == getRandomProductsState) &&
            (identical(other.searchProductsState, searchProductsState) ||
                other.searchProductsState == searchProductsState) &&
            const DeepCollectionEquality()
                .equals(other._randomProducts, _randomProducts) &&
            const DeepCollectionEquality()
                .equals(other._searchProducts, _searchProducts) &&
            (identical(other.productsPageIndex, productsPageIndex) ||
                other.productsPageIndex == productsPageIndex) &&
            (identical(other.productsHasReachedMax, productsHasReachedMax) ||
                other.productsHasReachedMax == productsHasReachedMax) &&
            (identical(other.isFetchingMoreProducts, isFetchingMoreProducts) ||
                other.isFetchingMoreProducts == isFetchingMoreProducts) &&
            (identical(other.productsSort, productsSort) ||
                other.productsSort == productsSort) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      getCategoryState,
      getCompaniesState,
      getRandomProductsState,
      searchProductsState,
      const DeepCollectionEquality().hash(_randomProducts),
      const DeepCollectionEquality().hash(_searchProducts),
      productsPageIndex,
      productsHasReachedMax,
      isFetchingMoreProducts,
      productsSort,
      errorMessage);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RequestStates getCategoryState,
            RequestStates getCompaniesState,
            RequestStates getRandomProductsState,
            RequestStates searchProductsState,
            List<GetRandomProductEntity> randomProducts,
            List<GetRandomProductEntity> searchProducts,
            int productsPageIndex,
            bool productsHasReachedMax,
            bool isFetchingMoreProducts,
            String? productsSort,
            String? errorMessage)
        initial,
  }) {
    return initial(
        getCategoryState,
        getCompaniesState,
        getRandomProductsState,
        searchProductsState,
        randomProducts,
        searchProducts,
        productsPageIndex,
        productsHasReachedMax,
        isFetchingMoreProducts,
        productsSort,
        errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RequestStates getCategoryState,
            RequestStates getCompaniesState,
            RequestStates getRandomProductsState,
            RequestStates searchProductsState,
            List<GetRandomProductEntity> randomProducts,
            List<GetRandomProductEntity> searchProducts,
            int productsPageIndex,
            bool productsHasReachedMax,
            bool isFetchingMoreProducts,
            String? productsSort,
            String? errorMessage)?
        initial,
  }) {
    return initial?.call(
        getCategoryState,
        getCompaniesState,
        getRandomProductsState,
        searchProductsState,
        randomProducts,
        searchProducts,
        productsPageIndex,
        productsHasReachedMax,
        isFetchingMoreProducts,
        productsSort,
        errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RequestStates getCategoryState,
            RequestStates getCompaniesState,
            RequestStates getRandomProductsState,
            RequestStates searchProductsState,
            List<GetRandomProductEntity> randomProducts,
            List<GetRandomProductEntity> searchProducts,
            int productsPageIndex,
            bool productsHasReachedMax,
            bool isFetchingMoreProducts,
            String? productsSort,
            String? errorMessage)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(
          getCategoryState,
          getCompaniesState,
          getRandomProductsState,
          searchProductsState,
          randomProducts,
          searchProducts,
          productsPageIndex,
          productsHasReachedMax,
          isFetchingMoreProducts,
          productsSort,
          errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements HomeState {
  const factory _Initial(
      {final RequestStates getCategoryState,
      final RequestStates getCompaniesState,
      final RequestStates getRandomProductsState,
      final RequestStates searchProductsState,
      final List<GetRandomProductEntity> randomProducts,
      final List<GetRandomProductEntity> searchProducts,
      final int productsPageIndex,
      final bool productsHasReachedMax,
      final bool isFetchingMoreProducts,
      final String? productsSort,
      final String? errorMessage}) = _$InitialImpl;

  @override
  RequestStates get getCategoryState;
  @override
  RequestStates get getCompaniesState;
  @override
  RequestStates get getRandomProductsState;
  @override
  RequestStates get searchProductsState;
  @override
  List<GetRandomProductEntity> get randomProducts;
  @override
  List<GetRandomProductEntity> get searchProducts;
  @override
  int get productsPageIndex;
  @override
  bool get productsHasReachedMax;
  @override
  bool get isFetchingMoreProducts;
  @override
  String? get productsSort;
  @override
  String? get errorMessage;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
