import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:junorno_news/features/mainApp/models/BlogCategoryAddModel.dart';

class AddBlogCategoryController {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<bool> addBlogCategory(String blogcategory, String slug) async {
    try {
      String? userId = await storage.read(key: "channel_id");
      if (userId == null) {
        throw Exception("User Id not found");
      }

      final String url = "https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/blogcategories";
      final apiUrl = Uri.parse(url);

      final response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          BlogCategoryAddModel(blogcategory: blogcategory, slug: slug).toJson(),
        ),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
