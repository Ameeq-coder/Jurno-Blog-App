import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junorno_news/features/authentication/controllers/AuthController.dart';
import 'package:junorno_news/features/authentication/controllers/LoginController.dart';
import 'package:junorno_news/features/mainApp/screens/categoryscreen.dart';
import 'package:junorno_news/utils/constants/colors.dart';
import '../../../models/User.dart';
import '../../Login/login.dart';

class SignupForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmpasswordController;
  final Authcontroller authController;

  const SignupForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmpasswordController,
    required this.authController,
  });

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isEmailVerified = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _isEmailVerified = RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: TColors.primary,
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
                    color: TColors.primary,
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: widget.emailController,
                  onChanged: _validateEmail,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.email, color: TColors.primary),
                    ),
                    suffixIcon: _isEmailVerified
                        ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.verified, color: TColors.primary),
                    ):null,
                    hintText: 'Enter Your Email',
                    hintStyle: TextStyle(color: TColors.primary),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: TColors.primary),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: TColors.primary),
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
                    color: TColors.primary,
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: widget.passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.lock, color: TColors.primary),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: TColors.primary,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    hintText: 'Enter Your Password',
                    hintStyle: TextStyle(color: TColors.primary),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: TColors.primary),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: TColors.primary),
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
                    color: TColors.primary,
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  obscureText: !_isConfirmPasswordVisible,
                  controller: widget.confirmpasswordController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.lock, color: TColors.primary),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: TColors.primary,
                      ),
                      onPressed: _toggleConfirmPasswordVisibility,
                    ),
                    hintText: 'Confirm Your Password',
                    hintStyle: TextStyle(color: TColors.primary),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: TColors.primary),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: TColors.primary),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final user = User(
                      email: widget.emailController.text,
                      password: widget.passwordController.text,
                      confirmpass: widget.confirmpasswordController.text,
                    );
                    try {
                      final userId = await widget.authController.Signup(user);
                      if (userId != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Signup successful!')),
                        );
                        Get.to(() => CategorySelectionScreen(userId: userId));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Signup failed: $e')),
                      );
                    }
                  },
                  child: Text('Create Account',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
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
                            color: TColors.primary,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(Login(loginController: LoginController() ,));
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
