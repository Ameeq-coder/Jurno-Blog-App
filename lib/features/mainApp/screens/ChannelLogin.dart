import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/UserApp/Controllers/ChannelLoginController.dart';
import 'package:junorno_news/features/UserApp/widgets/BlackTopContainer.dart';
import 'package:junorno_news/features/UserApp/widgets/ChannelSignupLogo.dart';
import '../../UserApp/Models/ChannelLoginModel.dart';
import 'ChannelSignup.dart';

class Channellogin extends StatefulWidget {
  @override
  _ChannelloginState createState() => _ChannelloginState();
}

class _ChannelloginState extends State<Channellogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Channellogincontroller loginController = Get.put(Channellogincontroller());

  bool isPasswordVisible = false;
  bool isVerifiedVisible = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkChannelName);
  }

  @override
  void dispose() {
    emailController.removeListener(_checkChannelName);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _checkChannelName() {
    setState(() {
      isVerifiedVisible = emailController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BlackTopContainer(),
          Positioned(
            top: 210,
            left: 0,
            right: 0,
            bottom: 0,
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
                    Text(
                      'Channel Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: TColors.black,
                      ),
                      textAlign: TextAlign.center,
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
                        suffixIcon: isVerifiedVisible
                            ? Icon(Icons.verified, color: Colors.green)
                            : null,
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
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(Icons.lock, color: TColors.black),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: TColors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
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
                    ElevatedButton(
                      onPressed: () async {
                        final channelLogin = ChannelLoginModel(
                          channelName: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        await loginController.loginchannel(channelLogin);
                      },
                      child: Text(
                        'Login',
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
                          text: 'Don’t Have An Account? ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'PoppinsLight',
                            color: TColors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Signup',
                              style: TextStyle(
                                color: TColors.black,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Add the navigation or action you want to perform on tap here
                                  print("Signup tapped");
                                  // Example: You can navigate to the signup screen like this:
                                  Get.to(Channelsignup()); // assuming you're using GetX for navigation
                                },
                            ),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
          ChannelSignupLogo()
        ],
      ),
    );
  }
}
