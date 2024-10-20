
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junorno_news/features/mainApp/screens/ChannelLogin.dart';

import 'package:junorno_news/features/mainApp/screens/ChannelProfile.dart';
import 'package:junorno_news/features/authentication/controllers/LoginController.dart';
import 'package:junorno_news/features/authentication/screens/Front%20Screen/front.dart';
import 'package:junorno_news/features/authentication/screens/Signup/signup.dart';
import 'package:junorno_news/features/mainApp/screens/AddTags.dart';
import 'package:junorno_news/features/mainApp/screens/TagsScreen.dart';
import 'package:junorno_news/features/mainApp/screens/UpdatePostScreen.dart';

import 'features/mainApp/screens/ChannelSignup.dart';
import 'features/UserApp/Screens/UserPostContent.dart';
import 'features/UserApp/Screens/userdownload.dart';
import 'features/UserApp/Screens/userhome.dart';
import 'features/authentication/screens/Login/login.dart';
import 'features/mainApp/screens/creatorhome.dart';
import 'features/mainApp/screens/AddPostScreen.dart';
import 'features/mainApp/screens/categoryscreen.dart';
import 'features/onboardingscreens/onboarding.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      home: OnboardingScreen(),
    );
  }
}