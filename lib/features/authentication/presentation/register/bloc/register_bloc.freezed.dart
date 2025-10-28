// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegisterEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() register,
    required TResult Function() sendOTP,
    required TResult Function() verifyAccount,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? register,
    TResult? Function()? sendOTP,
    TResult? Function()? verifyAccount,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? register,
    TResult Function()? sendOTP,
    TResult Function()? verifyAccount,
    TResult Function()? signWithGoogle,
    TResult Function()? signWithFacebook,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(Register value) register,
    required TResult Function(SendOTP value) sendOTP,
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Register value)? register,
    TResult? Function(SendOTP value)? sendOTP,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Register value)? register,
    TResult Function(SendOTP value)? sendOTP,
    TResult Function(VerifyAccount value)? verifyAccount,
    TResult Function(SignWithGoogle value)? signWithGoogle,
    TResult Function(SignWithFacebook value)? signWithFacebook,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterEventCopyWith<$Res> {
  factory $RegisterEventCopyWith(
          RegisterEvent value, $Res Function(RegisterEvent) then) =
      _$RegisterEventCopyWithImpl<$Res, RegisterEvent>;
}

/// @nodoc
class _$RegisterEventCopyWithImpl<$Res, $Val extends RegisterEvent>
    implements $RegisterEventCopyWith<$Res> {
  _$RegisterEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterEvent
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
    extends _$RegisterEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'RegisterEvent.started()';
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
    required TResult Function() register,
    required TResult Function() sendOTP,
    required TResult Function() verifyAccount,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? register,
    TResult? Function()? sendOTP,
    TResult? Function()? verifyAccount,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? register,
    TResult Function()? sendOTP,
    TResult Function()? verifyAccount,
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
    required TResult Function(Register value) register,
    required TResult Function(SendOTP value) sendOTP,
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Register value)? register,
    TResult? Function(SendOTP value)? sendOTP,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Register value)? register,
    TResult Function(SendOTP value)? sendOTP,
    TResult Function(VerifyAccount value)? verifyAccount,
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

abstract class _Started implements RegisterEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$RegisterImplCopyWith<$Res> {
  factory _$$RegisterImplCopyWith(
          _$RegisterImpl value, $Res Function(_$RegisterImpl) then) =
      __$$RegisterImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterImplCopyWithImpl<$Res>
    extends _$RegisterEventCopyWithImpl<$Res, _$RegisterImpl>
    implements _$$RegisterImplCopyWith<$Res> {
  __$$RegisterImplCopyWithImpl(
      _$RegisterImpl _value, $Res Function(_$RegisterImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterImpl implements Register {
  const _$RegisterImpl();

  @override
  String toString() {
    return 'RegisterEvent.register()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegisterImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() register,
    required TResult Function() sendOTP,
    required TResult Function() verifyAccount,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) {
    return register();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? register,
    TResult? Function()? sendOTP,
    TResult? Function()? verifyAccount,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) {
    return register?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? register,
    TResult Function()? sendOTP,
    TResult Function()? verifyAccount,
    TResult Function()? signWithGoogle,
    TResult Function()? signWithFacebook,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(Register value) register,
    required TResult Function(SendOTP value) sendOTP,
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) {
    return register(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Register value)? register,
    TResult? Function(SendOTP value)? sendOTP,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) {
    return register?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Register value)? register,
    TResult Function(SendOTP value)? sendOTP,
    TResult Function(VerifyAccount value)? verifyAccount,
    TResult Function(SignWithGoogle value)? signWithGoogle,
    TResult Function(SignWithFacebook value)? signWithFacebook,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(this);
    }
    return orElse();
  }
}

abstract class Register implements RegisterEvent {
  const factory Register() = _$RegisterImpl;
}

/// @nodoc
abstract class _$$SendOTPImplCopyWith<$Res> {
  factory _$$SendOTPImplCopyWith(
          _$SendOTPImpl value, $Res Function(_$SendOTPImpl) then) =
      __$$SendOTPImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SendOTPImplCopyWithImpl<$Res>
    extends _$RegisterEventCopyWithImpl<$Res, _$SendOTPImpl>
    implements _$$SendOTPImplCopyWith<$Res> {
  __$$SendOTPImplCopyWithImpl(
      _$SendOTPImpl _value, $Res Function(_$SendOTPImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SendOTPImpl implements SendOTP {
  const _$SendOTPImpl();

  @override
  String toString() {
    return 'RegisterEvent.sendOTP()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SendOTPImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() register,
    required TResult Function() sendOTP,
    required TResult Function() verifyAccount,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) {
    return sendOTP();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? register,
    TResult? Function()? sendOTP,
    TResult? Function()? verifyAccount,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) {
    return sendOTP?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? register,
    TResult Function()? sendOTP,
    TResult Function()? verifyAccount,
    TResult Function()? signWithGoogle,
    TResult Function()? signWithFacebook,
    required TResult orElse(),
  }) {
    if (sendOTP != null) {
      return sendOTP();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(Register value) register,
    required TResult Function(SendOTP value) sendOTP,
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) {
    return sendOTP(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Register value)? register,
    TResult? Function(SendOTP value)? sendOTP,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) {
    return sendOTP?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Register value)? register,
    TResult Function(SendOTP value)? sendOTP,
    TResult Function(VerifyAccount value)? verifyAccount,
    TResult Function(SignWithGoogle value)? signWithGoogle,
    TResult Function(SignWithFacebook value)? signWithFacebook,
    required TResult orElse(),
  }) {
    if (sendOTP != null) {
      return sendOTP(this);
    }
    return orElse();
  }
}

abstract class SendOTP implements RegisterEvent {
  const factory SendOTP() = _$SendOTPImpl;
}

/// @nodoc
abstract class _$$VerifyAccountImplCopyWith<$Res> {
  factory _$$VerifyAccountImplCopyWith(
          _$VerifyAccountImpl value, $Res Function(_$VerifyAccountImpl) then) =
      __$$VerifyAccountImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VerifyAccountImplCopyWithImpl<$Res>
    extends _$RegisterEventCopyWithImpl<$Res, _$VerifyAccountImpl>
    implements _$$VerifyAccountImplCopyWith<$Res> {
  __$$VerifyAccountImplCopyWithImpl(
      _$VerifyAccountImpl _value, $Res Function(_$VerifyAccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$VerifyAccountImpl implements VerifyAccount {
  const _$VerifyAccountImpl();

  @override
  String toString() {
    return 'RegisterEvent.verifyAccount()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VerifyAccountImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() register,
    required TResult Function() sendOTP,
    required TResult Function() verifyAccount,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) {
    return verifyAccount();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? register,
    TResult? Function()? sendOTP,
    TResult? Function()? verifyAccount,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) {
    return verifyAccount?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? register,
    TResult Function()? sendOTP,
    TResult Function()? verifyAccount,
    TResult Function()? signWithGoogle,
    TResult Function()? signWithFacebook,
    required TResult orElse(),
  }) {
    if (verifyAccount != null) {
      return verifyAccount();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(Register value) register,
    required TResult Function(SendOTP value) sendOTP,
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) {
    return verifyAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Register value)? register,
    TResult? Function(SendOTP value)? sendOTP,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) {
    return verifyAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Register value)? register,
    TResult Function(SendOTP value)? sendOTP,
    TResult Function(VerifyAccount value)? verifyAccount,
    TResult Function(SignWithGoogle value)? signWithGoogle,
    TResult Function(SignWithFacebook value)? signWithFacebook,
    required TResult orElse(),
  }) {
    if (verifyAccount != null) {
      return verifyAccount(this);
    }
    return orElse();
  }
}

abstract class VerifyAccount implements RegisterEvent {
  const factory VerifyAccount() = _$VerifyAccountImpl;
}

/// @nodoc
abstract class _$$SignWithGoogleImplCopyWith<$Res> {
  factory _$$SignWithGoogleImplCopyWith(_$SignWithGoogleImpl value,
          $Res Function(_$SignWithGoogleImpl) then) =
      __$$SignWithGoogleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignWithGoogleImplCopyWithImpl<$Res>
    extends _$RegisterEventCopyWithImpl<$Res, _$SignWithGoogleImpl>
    implements _$$SignWithGoogleImplCopyWith<$Res> {
  __$$SignWithGoogleImplCopyWithImpl(
      _$SignWithGoogleImpl _value, $Res Function(_$SignWithGoogleImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignWithGoogleImpl implements SignWithGoogle {
  const _$SignWithGoogleImpl();

  @override
  String toString() {
    return 'RegisterEvent.signWithGoogle()';
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
    required TResult Function() register,
    required TResult Function() sendOTP,
    required TResult Function() verifyAccount,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) {
    return signWithGoogle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? register,
    TResult? Function()? sendOTP,
    TResult? Function()? verifyAccount,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) {
    return signWithGoogle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? register,
    TResult Function()? sendOTP,
    TResult Function()? verifyAccount,
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
    required TResult Function(Register value) register,
    required TResult Function(SendOTP value) sendOTP,
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) {
    return signWithGoogle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Register value)? register,
    TResult? Function(SendOTP value)? sendOTP,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) {
    return signWithGoogle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Register value)? register,
    TResult Function(SendOTP value)? sendOTP,
    TResult Function(VerifyAccount value)? verifyAccount,
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

abstract class SignWithGoogle implements RegisterEvent {
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
    extends _$RegisterEventCopyWithImpl<$Res, _$SignWithFacebookImpl>
    implements _$$SignWithFacebookImplCopyWith<$Res> {
  __$$SignWithFacebookImplCopyWithImpl(_$SignWithFacebookImpl _value,
      $Res Function(_$SignWithFacebookImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignWithFacebookImpl implements SignWithFacebook {
  const _$SignWithFacebookImpl();

  @override
  String toString() {
    return 'RegisterEvent.signWithFacebook()';
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
    required TResult Function() register,
    required TResult Function() sendOTP,
    required TResult Function() verifyAccount,
    required TResult Function() signWithGoogle,
    required TResult Function() signWithFacebook,
  }) {
    return signWithFacebook();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? register,
    TResult? Function()? sendOTP,
    TResult? Function()? verifyAccount,
    TResult? Function()? signWithGoogle,
    TResult? Function()? signWithFacebook,
  }) {
    return signWithFacebook?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? register,
    TResult Function()? sendOTP,
    TResult Function()? verifyAccount,
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
    required TResult Function(Register value) register,
    required TResult Function(SendOTP value) sendOTP,
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(SignWithGoogle value) signWithGoogle,
    required TResult Function(SignWithFacebook value) signWithFacebook,
  }) {
    return signWithFacebook(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(Register value)? register,
    TResult? Function(SendOTP value)? sendOTP,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(SignWithGoogle value)? signWithGoogle,
    TResult? Function(SignWithFacebook value)? signWithFacebook,
  }) {
    return signWithFacebook?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(Register value)? register,
    TResult Function(SendOTP value)? sendOTP,
    TResult Function(VerifyAccount value)? verifyAccount,
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

abstract class SignWithFacebook implements RegisterEvent {
  const factory SignWithFacebook() = _$SignWithFacebookImpl;
}

/// @nodoc
mixin _$RegisterState {
  RequestStates get registerState => throw _privateConstructorUsedError;
  RequestStates get sendOTPState => throw _privateConstructorUsedError;
  RequestStates get signWithGoogleState => throw _privateConstructorUsedError;
  RequestStates get signWithFacebookState => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RequestStates registerState,
            RequestStates sendOTPState,
            RequestStates signWithGoogleState,
            RequestStates signWithFacebookState,
            String? errorMessage)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RequestStates registerState,
            RequestStates sendOTPState,
            RequestStates signWithGoogleState,
            RequestStates signWithFacebookState,
            String? errorMessage)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RequestStates registerState,
            RequestStates sendOTPState,
            RequestStates signWithGoogleState,
            RequestStates signWithFacebookState,
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

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterStateCopyWith<RegisterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStateCopyWith<$Res> {
  factory $RegisterStateCopyWith(
          RegisterState value, $Res Function(RegisterState) then) =
      _$RegisterStateCopyWithImpl<$Res, RegisterState>;
  @useResult
  $Res call(
      {RequestStates registerState,
      RequestStates sendOTPState,
      RequestStates signWithGoogleState,
      RequestStates signWithFacebookState,
      String? errorMessage});
}

/// @nodoc
class _$RegisterStateCopyWithImpl<$Res, $Val extends RegisterState>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerState = null,
    Object? sendOTPState = null,
    Object? signWithGoogleState = null,
    Object? signWithFacebookState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      registerState: null == registerState
          ? _value.registerState
          : registerState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      sendOTPState: null == sendOTPState
          ? _value.sendOTPState
          : sendOTPState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      signWithGoogleState: null == signWithGoogleState
          ? _value.signWithGoogleState
          : signWithGoogleState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      signWithFacebookState: null == signWithFacebookState
          ? _value.signWithFacebookState
          : signWithFacebookState // ignore: cast_nullable_to_non_nullable
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
    implements $RegisterStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RequestStates registerState,
      RequestStates sendOTPState,
      RequestStates signWithGoogleState,
      RequestStates signWithFacebookState,
      String? errorMessage});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerState = null,
    Object? sendOTPState = null,
    Object? signWithGoogleState = null,
    Object? signWithFacebookState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$InitialImpl(
      registerState: null == registerState
          ? _value.registerState
          : registerState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      sendOTPState: null == sendOTPState
          ? _value.sendOTPState
          : sendOTPState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      signWithGoogleState: null == signWithGoogleState
          ? _value.signWithGoogleState
          : signWithGoogleState // ignore: cast_nullable_to_non_nullable
              as RequestStates,
      signWithFacebookState: null == signWithFacebookState
          ? _value.signWithFacebookState
          : signWithFacebookState // ignore: cast_nullable_to_non_nullable
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
      {this.registerState = RequestStates.initial,
      this.sendOTPState = RequestStates.initial,
      this.signWithGoogleState = RequestStates.initial,
      this.signWithFacebookState = RequestStates.initial,
      this.errorMessage});

  @override
  @JsonKey()
  final RequestStates registerState;
  @override
  @JsonKey()
  final RequestStates sendOTPState;
  @override
  @JsonKey()
  final RequestStates signWithGoogleState;
  @override
  @JsonKey()
  final RequestStates signWithFacebookState;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'RegisterState.initial(registerState: $registerState, sendOTPState: $sendOTPState, signWithGoogleState: $signWithGoogleState, signWithFacebookState: $signWithFacebookState, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.registerState, registerState) ||
                other.registerState == registerState) &&
            (identical(other.sendOTPState, sendOTPState) ||
                other.sendOTPState == sendOTPState) &&
            (identical(other.signWithGoogleState, signWithGoogleState) ||
                other.signWithGoogleState == signWithGoogleState) &&
            (identical(other.signWithFacebookState, signWithFacebookState) ||
                other.signWithFacebookState == signWithFacebookState) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, registerState, sendOTPState,
      signWithGoogleState, signWithFacebookState, errorMessage);

  /// Create a copy of RegisterState
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
            RequestStates registerState,
            RequestStates sendOTPState,
            RequestStates signWithGoogleState,
            RequestStates signWithFacebookState,
            String? errorMessage)
        initial,
  }) {
    return initial(registerState, sendOTPState, signWithGoogleState,
        signWithFacebookState, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RequestStates registerState,
            RequestStates sendOTPState,
            RequestStates signWithGoogleState,
            RequestStates signWithFacebookState,
            String? errorMessage)?
        initial,
  }) {
    return initial?.call(registerState, sendOTPState, signWithGoogleState,
        signWithFacebookState, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RequestStates registerState,
            RequestStates sendOTPState,
            RequestStates signWithGoogleState,
            RequestStates signWithFacebookState,
            String? errorMessage)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(registerState, sendOTPState, signWithGoogleState,
          signWithFacebookState, errorMessage);
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

abstract class _Initial implements RegisterState {
  const factory _Initial(
      {final RequestStates registerState,
      final RequestStates sendOTPState,
      final RequestStates signWithGoogleState,
      final RequestStates signWithFacebookState,
      final String? errorMessage}) = _$InitialImpl;

  @override
  RequestStates get registerState;
  @override
  RequestStates get sendOTPState;
  @override
  RequestStates get signWithGoogleState;
  @override
  RequestStates get signWithFacebookState;
  @override
  String? get errorMessage;

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
