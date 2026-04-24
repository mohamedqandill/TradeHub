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
  String? get errorMessage => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RequestStates getCategoryState,
            RequestStates getCompaniesState,
            RequestStates getRandomProductsState,
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
      this.errorMessage});

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
  final String? errorMessage;

  @override
  String toString() {
    return 'HomeState.initial(getCategoryState: $getCategoryState, getCompaniesState: $getCompaniesState, getRandomProductsState: $getRandomProductsState, errorMessage: $errorMessage)';
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
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, getCategoryState,
      getCompaniesState, getRandomProductsState, errorMessage);

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
            String? errorMessage)
        initial,
  }) {
    return initial(getCategoryState, getCompaniesState, getRandomProductsState,
        errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RequestStates getCategoryState,
            RequestStates getCompaniesState,
            RequestStates getRandomProductsState,
            String? errorMessage)?
        initial,
  }) {
    return initial?.call(getCategoryState, getCompaniesState,
        getRandomProductsState, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RequestStates getCategoryState,
            RequestStates getCompaniesState,
            RequestStates getRandomProductsState,
            String? errorMessage)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(getCategoryState, getCompaniesState,
          getRandomProductsState, errorMessage);
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
      final String? errorMessage}) = _$InitialImpl;

  @override
  RequestStates get getCategoryState;
  @override
  RequestStates get getCompaniesState;
  @override
  RequestStates get getRandomProductsState;
  @override
  String? get errorMessage;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
