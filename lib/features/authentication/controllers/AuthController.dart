import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:junorno_news/features/authentication/models/User.dart';

class Authcontroller {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();



  final String signupurl =
      'https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/register';

  Future<String?> Signup(User user) async {
    final response = await http.post(
      Uri.parse(signupurl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final userId = responseData['userId'];

      await _secureStorage.write(key: 'user_id', value: userId);
      return userId;

      // Return the userId from response
    }else if(response.statusCode==400){
      throw Exception('Confirm Pass And Password Dont match');
    } else {
      throw Exception('User Already Exist');
    }

  }
}
