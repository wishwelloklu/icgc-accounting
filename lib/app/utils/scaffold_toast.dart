import 'package:flutter/material.dart';
import '../config/navigation_key.dart';

void showToast(
  String message, {
  void Function()? onFunction,
  bool showCloseIcon = true,
  bool autoHide = true,
}) {
  final currentState = AppNavigatorKeys.instance.scaffoldKey.currentState;
  SnackBar? currentSnackBar;
  currentState?.removeCurrentSnackBar();
  currentSnackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: autoHide ? 5 : 60),
    showCloseIcon: autoHide ? false : showCloseIcon,
    margin: const EdgeInsets.only(
        left: 5, right: 5, bottom: 10), // Adds margin around the snackbar
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    action: onFunction == null
        ? null
        : SnackBarAction(
            label: "OK",
            onPressed: onFunction,
          ),
  );

  // Show the updated SnackBar
  currentState?.showSnackBar(currentSnackBar).closed.then((_) {
    currentSnackBar = null;
  });
}
