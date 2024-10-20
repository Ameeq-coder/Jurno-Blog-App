import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../Models/UserCategoryModel.dart';
import '../Models/UserPostsModel.dart';  // Update this import path if necessary

class UserCategoryController {
  final storage = FlutterSecureStorage();

  // Fetch User Categories
  Future<List<UserCategoryModel>> fetchUserCategories() async {
    try {
      String? userId = await storage.read(key: "user_id");

      if (userId == null) {
        throw Exception("User ID not found in storage");
      }

      final response = await http.get(
        Uri.parse('https://blog-app-server-60pijkifb-ameeq-ahmads-projects.vercel.app/user/$userId/categories'),
      );

      if (response.statusCode == 200) {
        List<dynamic> categoriesJson = json.decode(response.body)['categories'];
        return categoriesJson.map((data) => UserCategoryModel.fromJson(data)).toList();
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }

  // Fetch Posts by Category
}
