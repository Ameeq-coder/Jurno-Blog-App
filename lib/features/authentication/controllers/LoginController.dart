import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:junorno_news/features/authentication/models/LoginModel.dart';

class LoginController {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<LoginModel> login(String email, String password) async {
    const String apiUrl = 'https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        LoginModel loginModel = LoginModel.fromJson(responseData);

        // Store the token securely
        await _secureStorage.write(
          key: 'auth_token',
          value: loginModel.token,
        );

        final userId=responseData['userId'];
        await _secureStorage.write(key: 'user_id', value: userId);

        return loginModel;

      } else if (response.statusCode == 403) {
        throw Exception('Incorrect Email or Password');
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print('Error during login: $e');
      throw e; // Rethrow the error to be handled in the UI
    }
  }
}
