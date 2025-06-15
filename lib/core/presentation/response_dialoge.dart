import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:accounting_app/app/routes/route_navigator.dart';
import 'package:accounting_app/app/theme/app_string.dart';
import 'package:accounting_app/app/theme/style.dart';
import 'package:accounting_app/core/funcs/platform_dialogue.dart';
import 'package:accounting_app/core/presentation/buttons/app_primary_button.dart';
import 'package:accounting_app/core/presentation/dialogue.dart';

enum DialogType { info, decision, danger }

class AppDialogue extends StatelessWidget {
  const AppDialogue({
    super.key,
    required this.title,
    required this.description,
    this.onOk,
    this.okText,
    required this.dialogType,
  });
  final String title;
  final String description;
  final String? okText;
  final VoidCallback? onOk;
  final DialogType dialogType;

  static bool _isDialogShowing = false;
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String description,
    required DialogType dialogType,
    VoidCallback? onOk,
    String? okText,
  }) async {
    if (_isDialogShowing) {
      return null;
    }

    _isDialogShowing = true;
    return await showPlatformDialogue(
      context: context,
      barrierDismissible: false,
      child: AppDialogue(
        title: title,
        description: description,
        okText: okText,
        onOk: () {
          popBack(context);
          if (onOk != null) {
            onOk();
          }
        },
        dialogType: dialogType,
      ),
    ).then((value) {
      _isDialogShowing = false;
      return value;
    });
  }

  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Platform.isIOS
          ? CupertinoAlertDialog(
              title: Text(
                title.isEmpty ? AppString.systemInfo : title,
                style: appTextStyle(),
              ),
              content: Text(description, style: appTextStyle()),
              actions: dialogType == DialogType.decision
                  ? [
                      CupertinoDialogAction(
                        onPressed: () => hide(context),
                        child: const Text('Cancel'),
                      ),
                      CupertinoDialogAction(
                        onPressed: () {
                          hide(context);
                          if (onOk != null) {
                            onOk!();
                          }
                        },
                        child: Text(okText ?? 'OK'),
                      ),
                    ]
                  : dialogType == DialogType.danger
                  ? [
                      CupertinoDialogAction(
                        onPressed: () => hide(context),
                        child: const Text('Cancel'),
                      ),
                      CupertinoDialogAction(
                        onPressed: () {
                          hide(context);

                          if (onOk != null) {
                            onOk!();
                          }
                        },
                        child: Text(okText ?? 'OK'),
                      ),
                    ]
                  : [
                      CupertinoDialogAction(
                        onPressed: () {
                          hide(context);
                        },
                        child: Text(okText ?? 'OK'),
                      ),
                    ],
            )
          : Dialogue(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: appTextStyle()),
                    const Gap(15),
                    Text(description, style: appTextStyle()),
                    const Gap(20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            dialogType == DialogType.decision ||
                                dialogType == DialogType.danger
                            ? 10
                            : 70,
                      ),
                      child: dialogType == DialogType.decision
                          ? Row(
                              children: [
                                Expanded(
                                  child: PrimaryButton(
                                    text: 'Cancel',
                                    onPressed: () => hide(context),
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: PrimaryButton(
                                    text: okText ?? 'OK',
                                    onPressed: onOk,
                                  ),
                                ),
                              ],
                            )
                          : dialogType == DialogType.danger
                          ? Row(
                              children: [
                                Expanded(
                                  child: PrimaryButton(
                                    text: 'Cancel',
                                    onPressed: () => hide(context),
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: PrimaryButton(
                                    text: okText ?? 'OK',
                                    textColor: Colors.red,
                                    backgroundColor: Colors.red.withValues(
                                      alpha: .3,
                                    ),
                                    onPressed: onOk,
                                  ),
                                ),
                              ],
                            )
                          : PrimaryButton(
                              text: 'OK',
                              onPressed: () => hide(context),
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
