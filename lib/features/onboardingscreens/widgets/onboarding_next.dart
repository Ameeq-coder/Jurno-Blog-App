
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../utils/device/device_utilty.dart';
import '../onboarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }
  @override
  Widget build(BuildContext context) {


    return Positioned(
      right:24.0,
      bottom:TDeviceUtils.getBottomNavigationBarHeight() + 7,
        child: TextButton(
          onPressed: () => OnboardingController.instance.nextPage(),
          child: const Text("Next",style: TextStyle(
              color: TColors.primary
          ),),
        ));
  }
}
