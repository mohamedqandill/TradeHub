// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CategoryDetailsState {
  RequestStates get getCompaniesState => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CategoryDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryDetailsStateCopyWith<CategoryDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryDetailsStateCopyWith<$Res> {
  factory $CategoryDetailsStateCopyWith(CategoryDetailsState value,
          $Res Function(CategoryDetailsState) then) =
      _$CategoryDetailsStateCopyWithImpl<$Res, CategoryDetailsState>;
  @useResult
  $Res call({RequestStates getCompaniesState, String? errorMessage});
}

/// @nodoc
class _$CategoryDetailsStateCopyWithImpl<$Res,
        $Val extends CategoryDetailsState>
    implements $CategoryDetailsStateCopyWith<$Res> {
  _$CategoryDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? getCompaniesState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      getCompaniesState: null == getCompaniesState
          ? _value.getCompaniesState
          : getCompaniesState // ignore: cast_nullable_to_non_nullable
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
    implements $CategoryDetailsStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RequestStates getCompaniesState, String? errorMessage});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CategoryDetailsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? getCompaniesState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$InitialImpl(
      getCompaniesState: null == getCompaniesState
          ? _value.getCompaniesState
          : getCompaniesState // ignore: cast_nullable_to_non_nullable
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
      {this.getCompaniesState = RequestStates.initial, this.errorMessage});

  @override
  @JsonKey()
  final RequestStates getCompaniesState;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CategoryDetailsState(getCompaniesState: $getCompaniesState, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.getCompaniesState, getCompaniesState) ||
                other.getCompaniesState == getCompaniesState) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, getCompaniesState, errorMessage);

  /// Create a copy of CategoryDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class _Initial implements CategoryDetailsState {
  const factory _Initial(
      {final RequestStates getCompaniesState,
      final String? errorMessage}) = _$InitialImpl;

  @override
  RequestStates get getCompaniesState;
  @override
  String? get errorMessage;

  /// Create a copy of CategoryDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
