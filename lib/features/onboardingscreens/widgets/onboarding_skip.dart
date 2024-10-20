
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/device/device_utilty.dart';
import '../../../constants/colors.dart';
import '../onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });
  static const double defaultSpace = 24.0;


  @override
  Widget build(BuildContext context) {
    return Positioned(
        left:24.0,
        bottom:TDeviceUtils.getBottomNavigationBarHeight() + 7,
        child: TextButton(
          onPressed: () => OnboardingController.instance.skipPage(),
          child: const Text("Skip",style: TextStyle(
            color: TColors.primary
          ),),
        ));
  }
}
