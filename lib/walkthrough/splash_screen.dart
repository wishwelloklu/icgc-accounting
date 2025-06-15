import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accounting_app/app/routes/app_routes.dart';
import 'package:accounting_app/app/routes/route_navigator.dart';
import 'package:accounting_app/app/theme/app_images.dart';
import 'package:accounting_app/app/theme/style.dart';
import 'package:accounting_app/app/utils/svg_icon.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Navigate to the next screen after a delay
      Future.delayed(const Duration(seconds: 3), () {
        routeAndRemoveNavigator(context, AppRoutes.login);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Positioned.fill(
            child: SvgIcon(icon: AppImages.splash, fit: BoxFit.cover),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logo,
                width: 100,
                height: 100,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ICGC',
                    style: appTextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Text(
                    'International Christian Gospel Church',
                    style: appTextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
