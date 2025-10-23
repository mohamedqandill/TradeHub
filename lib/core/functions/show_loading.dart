import 'package:flutter/material.dart';

showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

hideDialog(BuildContext context) {
  Navigator.pop(context);
}
