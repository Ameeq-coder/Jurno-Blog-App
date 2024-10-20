
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junorno_news/features/onboardingscreens/widgets/OnBoardingDotNavigation.dart';
import 'package:junorno_news/features/onboardingscreens/widgets/onboarding_next.dart';
import 'package:junorno_news/features/onboardingscreens/widgets/onboarding_page.dart';
import 'package:junorno_news/features/onboardingscreens/widgets/onboarding_skip.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/constants/image_strings.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {



    final controller=Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        PageView(
          controller: controller.pagecontroller,
          onPageChanged: controller.updatePageIndicator,
          children: [
            OnboardingPage(
              animation: 'assets/images/onboard1.png',
              title: "Discover, engage and read the latest articles oras well as share your own thoughts and ideas with the community",
            ),
            OnboardingPage(
              animation: 'assets/images/onboard2.png',
              title: "Customize your reading experience and join the conversation by creating an account.",
            ),
            OnboardingPage(
              animation: 'assets/images/onboard3.png',
              title: "Explore a wide selection of categories, or use the search bar to find specific topics",
            ),
          ],
        ),
        const OnBoardingSkip(),
        const OnBoardingDotNavigation(),
        const OnBoardingNextButton()
      ]),
    );
  }
}


