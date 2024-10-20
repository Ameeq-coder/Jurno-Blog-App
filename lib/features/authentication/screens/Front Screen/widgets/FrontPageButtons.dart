import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junorno_news/features/authentication/controllers/LoginController.dart';
import 'package:junorno_news/features/authentication/screens/Login/login.dart';
import 'package:junorno_news/utils/constants/image_strings.dart';

import '../../Signup/signup.dart';

class FrontPageButtons extends StatelessWidget {
  const FrontPageButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60, // Adjust to position the buttons vertically as needed
      left: 20,
      right: 20,
      child: Column(children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            // Background color
            minimumSize: Size(double.infinity, 50),
            // Full-width button
            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        onPressed: () => Get.to(() => Login(loginController: LoginController())),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: ImageIcon(
                  AssetImage(
                    TImages.loginbuttonimg,
                  ),
                  color: Colors.white,
                ),
                width: 20.0,
                height: 20.0, // Specify the size of the icon
              ),

            ],
          ),
        ),
        SizedBox(height: 10),
        OutlinedButton(
          style: ElevatedButton.styleFrom(
            side: BorderSide(color: Colors.white), // Border color
            minimumSize: Size(double.infinity, 50), // Full-width button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () => Get.to(() => signup()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Signup',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: ImageIcon(
                  AssetImage(
                    TImages.signupbuttonimg,
                  ),
                  color: Colors.white,
                ),
                width: 20.0,
                height: 20.0, // Specify the size of the icon
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
