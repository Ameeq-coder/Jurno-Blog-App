import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage(
      {super.key,
      required this.animation,
      required this.title,
      });

  final String animation, title;

  static const double defaultSpace = 24.0;

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultSpace),
      child: Column(
        children: [
          Image.asset(
        animation,
          width: screenWidth()*0.8,
          height: screenHeight()*0.6,),
          Text(
            title,
            style: TextStyle(
              fontSize: 14
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16.0,
          ),

        ],
      ),
    );
  }
}
