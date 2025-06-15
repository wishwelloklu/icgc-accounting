import 'package:flutter/material.dart';

Future<T?> routeNavigator<T extends Object?>(
    BuildContext context, String routeName,
    {dynamic arguments}) async {
  return Navigator.pushNamed(context, routeName, arguments: arguments);
}

routeAndRemoveNavigator(BuildContext context, String routeName,
    {dynamic arguments}) {
  Navigator.of(context).pushNamedAndRemoveUntil(
      routeName, (Route<dynamic> route) => false,
      arguments: arguments);
}

routeAndReplaceNavigator(BuildContext context, String routeName,
    {dynamic arguments}) {
  Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
}

popBack<T extends Object?>(BuildContext context, [T? result]) async {
  Navigator.pop(context, result);
}
