import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:junorno_news/features/onboardingscreens/onboarding.dart';
import 'features/UserApp/Screens/userhome.dart';
import 'features/authentication/screens/Front Screen/front.dart';
import 'features/authentication/screens/Login/login.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Widget? _initialScreen;

  @override
  void initState() {
    super.initState();
    _checkKey();
  }

  Future<void> _checkKey() async {
    // Assuming you're checking for a key named "isLoggedIn"
    String? keyValue = await _secureStorage.read(key: 'user_id');
    setState(() {
      if (keyValue != null) {
        // If the key exists, navigate to the Home/Channel screen
        _initialScreen = UserHome();  // Replace with your Channel Home screen
      } else {
        // If the key does not exist, navigate to the Login screen
        _initialScreen = OnboardingScreen();  // Replace with your Login screen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      home: _initialScreen ?? const Scaffold(
        body: Center(child: CircularProgressIndicator()),  // Loading indicator while checking
      ),
    );
  }
}
