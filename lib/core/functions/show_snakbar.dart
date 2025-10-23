import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradehub/core/localization/locale_keys.g.dart';

showSuccessSnackBar(BuildContext context, {required String messageTitle}) {
  var snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: tr(LocaleKeys.congrats),
      message: messageTitle,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.success,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showFailureSnackBar(BuildContext context, {required String messageTitle}) {
  var snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: tr(LocaleKeys.error),
      message: messageTitle,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.failure,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
