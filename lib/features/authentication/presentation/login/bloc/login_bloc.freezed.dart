// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() login,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? login,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? login,
    TResult Function()? signWithGoogle,
    TResult Function()? signWithFacebook,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(Login value) login,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Login value)? login,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Login value)? login,
    TResult Function(SignWithGoogle value)? signWithGoogle,
    TResult Function(SignWithFacebook value)? signWithFacebook,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEventCopyWith<$Res> {
  factory $LoginEventCopyWith(
          LoginEvent value, $Res Function(LoginEvent) then) =
      _$LoginEventCopyWithImpl<$Res, LoginEvent>;
}

/// @nodoc
class _$LoginEventCopyWithImpl<$Res, $Val extends LoginEvent>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'LoginEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() login,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? login,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? login,
    TResult Function()? signWithGoogle,
    TResult Function()? signWithFacebook,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(Login value) login,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Login value)? login,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Login value)? login,
    TResult Function(SignWithGoogle value)? signWithGoogle,
    TResult Function(SignWithFacebook value)? signWithFacebook,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements LoginEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$LoginImplCopyWith<$Res> {
  factory _$$LoginImplCopyWith(
          _$LoginImpl value, $Res Function(_$LoginImpl) then) =
      __$$LoginImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginImpl>
    implements _$$LoginImplCopyWith<$Res> {
  __$$LoginImplCopyWithImpl(
      _$LoginImpl _value, $Res Function(_$LoginImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginImpl implements Login {
  const _$LoginImpl();

  @override
  String toString() {
    return 'LoginEvent.login()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() login,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) {
    return login();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? login,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) {
    return login?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? login,
    TResult Function()? signWithGoogle,
    TResult Function()? signWithFacebook,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(Login value) login,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Login value)? login,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Login value)? login,
    TResult Function(SignWithGoogle value)? signWithGoogle,
    TResult Function(SignWithFacebook value)? signWithFacebook,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class Login implements LoginEvent {
  const factory Login() = _$LoginImpl;
}

/// @nodoc
abstract class _$$SignWithGoogleImplCopyWith<$Res> {
  factory _$$SignWithGoogleImplCopyWith(_$SignWithGoogleImpl value,
          $Res Function(_$SignWithGoogleImpl) then) =
      __$$SignWithGoogleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignWithGoogleImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$SignWithGoogleImpl>
    implements _$$SignWithGoogleImplCopyWith<$Res> {
  __$$SignWithGoogleImplCopyWithImpl(
      _$SignWithGoogleImpl _value, $Res Function(_$SignWithGoogleImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignWithGoogleImpl implements SignWithGoogle {
  const _$SignWithGoogleImpl();

  @override
  String toString() {
    return 'LoginEvent.signWithGoogle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignWithGoogleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() login,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) {
    return signWithGoogle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? login,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) {
    return signWithGoogle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? login,
    TResult Function()? signWithGoogle,
    TResult Function()? signWithFacebook,
    required TResult orElse(),
  }) {
    if (signWithGoogle != null) {
      return signWithGoogle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(Login value) login,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) {
    return signWithGoogle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Login value)? login,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) {
    return signWithGoogle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Login value)? login,
    TResult Function(SignWithGoogle value)? signWithGoogle,
    TResult Function(SignWithFacebook value)? signWithFacebook,
    required TResult orElse(),
  }) {
    if (signWithGoogle != null) {
      return signWithGoogle(this);
    }
    return orElse();
  }
}

abstract class SignWithGoogle implements LoginEvent {
  const factory SignWithGoogle() = _$SignWithGoogleImpl;
}

/// @nodoc
abstract class _$$SignWithFacebookImplCopyWith<$Res> {
  factory _$$SignWithFacebookImplCopyWith(_$SignWithFacebookImpl value,
          $Res Function(_$SignWithFacebookImpl) then) =
      __$$SignWithFacebookImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignWithFacebookImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$SignWithFacebookImpl>
    implements _$$SignWithFacebookImplCopyWith<$Res> {
  __$$SignWithFacebookImplCopyWithImpl(_$SignWithFacebookImpl _value,
      $Res Function(_$SignWithFacebookImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignWithFacebookImpl implements SignWithFacebook {
  const _$SignWithFacebookImpl();

  @override
  String toString() {
    return 'LoginEvent.signWithFacebook()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignWithFacebookImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() login,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) {
    return signWithFacebook();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? login,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) {
    return signWithFacebook?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? login,
    TResult Function()? signWithGoogle,
    TResult Function()? signWithFacebook,
    required TResult orElse(),
  }) {
    if (signWithFacebook != null) {
      return signWithFacebook();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(Login value) login,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) {
    return signWithFacebook(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Login value)? login,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) {
    return signWithFacebook?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Login value)? login,
    TResult Function(SignWithGoogle value)? signWithGoogle,
    TResult Function(SignWithFacebook value)? signWithFacebook,
    required TResult orElse(),
  }) {
    if (signWithFacebook != null) {
      return signWithFacebook(this);
    }
    return orElse();
  }
}

abstract class SignWithFacebook implements LoginEvent {
  const factory SignWithFacebook() = _$SignWithFacebookImpl;
}

/// @nodoc
mixin _$LoginState {
  RequestStates get loginState => throw _privateConstructorUsedError;
  RequestStates get signWithFacebookState => throw _privateConstructorUsedError;
  RequestStates get signWithGoogleState => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RequestStates loginState,
            RequestStates signWithFacebookState,
            RequestStates signWithGoogleState,
            String? errorMessage)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RequestStates loginState,
            RequestStates signWithFacebookState,
            RequestStates signWithGoogleState,
            String? errorMessage)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RequestStates loginState,
            RequestStates signWithFacebookState,
            RequestStates signWithGoogleState,
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

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {RequestStates loginState,
      RequestStates signWithFacebookState,
      RequestStates signWithGoogleState,
      String? errorMessage});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginState = null,
    Object? signWithFacebookState = null,
    Object? signWithGoogleState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      loginState: null == loginState
          ? _value.loginState
          : loginState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      signWithFacebookState: null == signWithFacebookState
          ? _value.signWithFacebookState
          : signWithFacebookState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      signWithGoogleState: null == signWithGoogleState
          ? _value.signWithGoogleState
          : signWithGoogleState // ignore: cast_nullable_to_non_nullable
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
    implements $LoginStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RequestStates loginState,
      RequestStates signWithFacebookState,
      RequestStates signWithGoogleState,
      String? errorMessage});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginState = null,
    Object? signWithFacebookState = null,
    Object? signWithGoogleState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$InitialImpl(
      loginState: null == loginState
          ? _value.loginState
          : loginState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      signWithFacebookState: null == signWithFacebookState
          ? _value.signWithFacebookState
          : signWithFacebookState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      signWithGoogleState: null == signWithGoogleState
          ? _value.signWithGoogleState
          : signWithGoogleState // ignore: cast_nullable_to_non_nullable
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
      {this.loginState = RequestStates.initial,
      this.signWithFacebookState = RequestStates.initial,
      this.signWithGoogleState = RequestStates.initial,
      this.errorMessage});

  @override
  @JsonKey()
  final RequestStates loginState;
  @override
  @JsonKey()
  final RequestStates signWithFacebookState;
  @override
  @JsonKey()
  final RequestStates signWithGoogleState;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'LoginState.initial(loginState: $loginState, signWithFacebookState: $signWithFacebookState, signWithGoogleState: $signWithGoogleState, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.loginState, loginState) ||
                other.loginState == loginState) &&
            (identical(other.signWithFacebookState, signWithFacebookState) ||
                other.signWithFacebookState == signWithFacebookState) &&
            (identical(other.signWithGoogleState, signWithGoogleState) ||
                other.signWithGoogleState == signWithGoogleState) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loginState,
      signWithFacebookState, signWithGoogleState, errorMessage);

  /// Create a copy of LoginState
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
            RequestStates loginState,
            RequestStates signWithFacebookState,
            RequestStates signWithGoogleState,
            String? errorMessage)
        initial,
  }) {
    return initial(
        loginState, signWithFacebookState, signWithGoogleState, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RequestStates loginState,
            RequestStates signWithFacebookState,
            RequestStates signWithGoogleState,
            String? errorMessage)?
        initial,
  }) {
    return initial?.call(
        loginState, signWithFacebookState, signWithGoogleState, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RequestStates loginState,
            RequestStates signWithFacebookState,
            RequestStates signWithGoogleState,
            String? errorMessage)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(
          loginState, signWithFacebookState, signWithGoogleState, errorMessage);
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

abstract class _Initial implements LoginState {
  const factory _Initial(
      {final RequestStates loginState,
      final RequestStates signWithFacebookState,
      final RequestStates signWithGoogleState,
      final String? errorMessage}) = _$InitialImpl;

  @override
  RequestStates get loginState;
  @override
  RequestStates get signWithFacebookState;
  @override
  RequestStates get signWithGoogleState;
  @override
  String? get errorMessage;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
