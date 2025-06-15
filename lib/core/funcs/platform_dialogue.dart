import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> showPlatformDialogue({
  required BuildContext context,
  required Widget child,
  bool? barrierDismissible,
}) async {
  if (Platform.isAndroid) {
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (context) {
        return child;
      },
    );
  } else {
    await showCupertinoDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (context) {
        return child;
      },
    );
  }
}
