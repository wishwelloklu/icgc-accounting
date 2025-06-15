import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:accounting_app/app/routes/app_routes.dart';
import 'package:accounting_app/app/routes/route_navigator.dart';
import 'package:accounting_app/app/theme/app_colors.dart';
import 'package:accounting_app/app/theme/app_images.dart';
import 'package:accounting_app/app/theme/style.dart';
import 'package:accounting_app/app/utils/svg_icon.dart';
import 'package:accounting_app/core/presentation/buttons/app_primary_button.dart';
import 'package:accounting_app/core/presentation/text_field/input_text_field.dart';
import 'package:accounting_app/core/presentation/text_field/password_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _checked = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned.fill(
            child: SvgIcon(icon: AppImages.splash, fit: BoxFit.cover),
          ),

          Positioned(
            top: 105,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImages.logo),
                Gap(24),
                Text(
                  "Sign in to Account",
                  style: appTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Gap(12),
                Text(
                  "Enter your emails to log in",
                  style: appTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            top: size.height * .35,
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 18),
                children: [
                  Gap(47),
                  InputTextField(
                    labelText: 'Email',
                    isRequired: true,
                    hintText: 'example@gmail.com',
                    isEmail: true,
                  ),
                  Gap(20),

                  PrimaryButton(
                    text: 'Login',
                    backgroundColor: AppColors.primaryColor,
                    height: 56,
                    onPressed: () {
                      routeAndRemoveNavigator(context, AppRoutes.otpPage);
                    },
                  ),
                  Gap(20),
                  RichText(
                    text: TextSpan(
                      text: "Don't have account? ",
                      children: [TextSpan(text: 'Create an account')],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
