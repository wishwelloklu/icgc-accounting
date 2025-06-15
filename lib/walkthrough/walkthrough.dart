import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:accounting_app/app/routes/app_routes.dart';
import 'package:accounting_app/app/routes/route_navigator.dart';
import 'package:accounting_app/app/theme/app_colors.dart';
import 'package:accounting_app/app/theme/style.dart';
import 'package:accounting_app/core/presentation/buttons/app_primary_button.dart';

class Walkthrough extends ConsumerStatefulWidget {
  const Walkthrough({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WalkthroughState();
}

class _WalkthroughState extends ConsumerState<Walkthrough> {
  late final PageController _pageController;
  bool isLast = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = WalkthroughData.data;

    return Scaffold(
      body: Stack(
        children: [
          // Swipable images
          PageView.builder(
            padEnds: false,
            onPageChanged: (value) {
              isLast = value == (WalkthroughData.data.length - 1);
              setState(() {});
            },
            physics: NeverScrollableScrollPhysics(
              parent: ClampingScrollPhysics(),
            ),
            controller: _pageController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Image.asset(
                data[index].image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
          ),
          // Gradient + Text overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double page =
                    _pageController.hasClients && _pageController.page != null
                    ? _pageController.page!
                    : _pageController.initialPage.toDouble();

                int current = page.floor();
                int next = (page.floor() + 1).clamp(0, data.length - 1);

                double fade = 1.0 - (page - current).abs();

                // Interpolate between current and next page text
                final currentData = data[current];
                final nextData = data[next];

                String title;
                String description;
                double opacityCurrent = 1.0 - (page - current).abs();
                double opacityNext = (page - current).abs();

                if (opacityCurrent >= opacityNext) {
                  title = currentData.title;
                  description = currentData.description;
                } else {
                  title = nextData.title;
                  description = nextData.description;
                }

                return Container(
                  height: MediaQuery.sizeOf(context).height * .5,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,

                      colors: [
                        Color(0xFF14371B).withValues(alpha: .0),
                        Color(0xFF14371B).withValues(alpha: .2),
                        Color(0xFF14371B).withValues(alpha: .5),
                        Color(0xFF14371B).withValues(alpha: .9),
                        Color(0xFF14371B),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Opacity(
                          opacity: fade.clamp(0.0, 1.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                title,
                                style: appTextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                description,
                                style: appTextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Gap(40),
                        PrimaryButton(
                          text: isLast ? 'Finish' : 'Next',
                          backgroundColor: AppColors.yellow,
                          onPressed: () {
                            isLast
                                ? routeAndRemoveNavigator(
                                    context,
                                    AppRoutes.login,
                                  )
                                : _pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.decelerate,
                                  );
                          },
                          textColor: AppColors.blackColor,
                        ),
                        Gap(80),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WalkthroughData {
  final String title;
  final String description;
  final String image;

  WalkthroughData({
    required this.title,
    required this.description,
    required this.image,
  });

  static List<WalkthroughData> get data => [
    WalkthroughData(
      title: 'Listen. Learn. Grow.',
      description:
          'Catch up on Sunday messages and midweek preachings , listen to uplifting podcasts wherever you are.',
      image: 'assets/png/walkthrough_one.png',
    ),
    WalkthroughData(
      title: 'Stay Connected, Anytime',
      description:
          'Catch up on church posts, events, and sermons — all in one place. Never miss a moment again.',
      image: 'assets/png/walkthrough_two.png',
    ),
    WalkthroughData(
      title: 'Daily Declarations, Daily Growth',
      description:
          'Support the ministry through easy and secure giving. Every seed you sow makes a difference.',
      image: 'assets/png/walkthrough_three.png',
    ),
  ];
}
