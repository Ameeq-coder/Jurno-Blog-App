import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/authentication/screens/Front%20Screen/widgets/BackgroundImage.dart';
import 'package:junorno_news/features/authentication/screens/Front%20Screen/widgets/FrontPageButtons.dart';
import 'package:junorno_news/features/authentication/screens/Front%20Screen/widgets/LogoImage.dart';
import 'package:junorno_news/features/authentication/screens/Signup/signup.dart';
import 'package:junorno_news/utils/constants/image_strings.dart';
import 'package:junorno_news/utils/constants/text_strings.dart';

import 'widgets/FrontPageTexts.dart';

class front extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackgroundImage(),
          LogoImage(),
          FrontPageTexts(),
          FrontPageButtons()
        ],
      ),
    );
  }
}




