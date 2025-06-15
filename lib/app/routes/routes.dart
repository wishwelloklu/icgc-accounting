import 'dart:io';

import 'package:accounting_app/features/dashboard/pages/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accounting_app/app/routes/app_routes.dart';
import 'package:accounting_app/app/routes/route_type.dart';
import 'package:accounting_app/features/auth/login_page.dart';
import 'package:accounting_app/features/auth/otp_page.dart';
import 'package:accounting_app/walkthrough/splash_screen.dart';
import 'package:accounting_app/walkthrough/walkthrough.dart';

class Routes {
  static Map<String, RouteType> _resolveRoutes() {
    return {
      AppRoutes.splash: (context, settings) => const SplashScreen(),
      AppRoutes.walkthrough: (context, settings) => const Walkthrough(),
      AppRoutes.login: (context, settings) => const LoginPage(),
      AppRoutes.otpPage: (context, settings) => const OtpPage(),
      AppRoutes.dashboard: (context, settings) => const Dashboard(),
    };
  }

  static Route onGenerateRoutes(RouteSettings settings) {
    var routes = _resolveRoutes();
    final RouteType? child = routes[settings.name];

    if (child == null) {
      throw const FormatException("--- Route doesn't exist");
    }

    Widget builder(BuildContext context) {
      return child(context, settings);
    }

    if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: (context) => builder(context),
        settings: settings,
      );
    } else {
      return MaterialPageRoute(
        builder: (context) => builder(context),
        settings: settings, // Pass settings including arguments
      );
    }
  }
}
