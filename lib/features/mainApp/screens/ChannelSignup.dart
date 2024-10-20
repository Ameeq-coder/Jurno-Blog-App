import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/UserApp/widgets/BlackTopContainer.dart';
import 'package:junorno_news/features/authentication/screens/Signup/widgets/OrangeTopContainer.dart';
import 'package:junorno_news/features/authentication/screens/Signup/widgets/SignupForm.dart';
import 'package:junorno_news/features/authentication/screens/Signup/widgets/SignupLogo.dart';
import 'package:junorno_news/features/mainApp/screens/ChannelLogin.dart';

import '../../UserApp/Controllers/ChannelSignupController.dart';
import '../../UserApp/Models/ChannelSignupModel.dart';
import '../../UserApp/widgets/ChannelSignupForm.dart';
import '../../UserApp/widgets/ChannelSignupLogo.dart';
import 'ChannelImg.dart';

class Channelsignup extends StatefulWidget {
  @override
  _ChannelsignupState createState() => _ChannelsignupState();
}

class _ChannelsignupState extends State<Channelsignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  final ChannelSignupController authController = Get.put(ChannelSignupController());

  bool _isPasswordVisible = false; // to toggle password visibility
  bool _isConfirmPasswordVisible = false; // to toggle confirm password visibility

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          BlackTopContainer(),
          Positioned(
            top: 210,
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Text(
                          'Channel Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: TColors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: TColors.black,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.person_2_outlined, color: Colors.black),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.verified, color: TColors.black),
                          ),
                          hintText: 'Enter Your Channel Name',
                          hintStyle: TextStyle(color: TColors.black),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TColors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TColors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: TColors.black,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible, // Toggle based on visibility state
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.lock, color: TColors.black),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                              });
                            },
                            child: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: TColors.black,
                            ),
                          ),
                          hintText: 'Enter Your Password',
                          hintStyle: TextStyle(color: TColors.black),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TColors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TColors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Confirm Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: TColors.black,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: confirmpasswordController,
                        obscureText: !_isConfirmPasswordVisible, // Toggle visibility
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.lock, color: TColors.black),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible; // Toggle visibility
                              });
                            },
                            child: Icon(
                              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: TColors.black,
                            ),
                          ),
                          hintText: 'Confirm Your Password',
                          hintStyle: TextStyle(color: TColors.black),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TColors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TColors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (passwordController.text == confirmpasswordController.text) {
                            final channel = ChannelSignupModel(
                              channelName: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            try {
                              final channelId = await authController.signUpChannel(channel);
                              if (channelId != null) {
                                Get.snackbar('Success', 'Channel created successfully');
                                Get.to(() => ChannelImageUploadScreen());
                              }
                            } catch (e) {
                              Get.snackbar('Error', e.toString());
                            }
                          } else {
                            Get.snackbar('Error', 'Passwords do not match');
                          }
                        },
                        child: Text(
                          'Create Channel',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.black,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'PoppinsLight',
                              color: TColors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  color: TColors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(Channellogin()); // Navigate to the login screen
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ChannelSignupLogo(),
        ],
      ),
    );
  }
}



