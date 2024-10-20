import 'package:flutter/material.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/authentication/screens/Signup/widgets/OrangeTopContainer.dart';
import 'package:junorno_news/features/authentication/screens/Signup/widgets/SignupForm.dart';
import 'package:junorno_news/features/authentication/screens/Signup/widgets/SignupLogo.dart';

import '../../controllers/AuthController.dart';
import '../../models/User.dart';

class signup extends StatelessWidget {
  final Authcontroller authController = Authcontroller();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      // Ensure the view adjusts when the keyboard is shown
      body: Stack(
        children: [
          OrangeTopContainer(),
          SignupForm(emailController: emailController, passwordController: passwordController, confirmpasswordController: confirmpasswordController, authController: authController),
          SignupLogo(),
        ],
      ),
    );
  }
}



