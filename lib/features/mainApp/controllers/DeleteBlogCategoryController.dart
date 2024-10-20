import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DeleteBlogCategoryController {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<bool> deleteBlogCategory(String blogCategory) async {
    try {
      String? userId = await storage.read(key: "channel_id");
      if (userId == null) {
        throw Exception("User ID not found");
      }

      final String url = 'https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/blogcategories';
      final Uri apiUrl = Uri.parse(url);
      final response = await http.delete(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'blogcategory': blogCategory}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete blog category: ${jsonDecode(response.body)['msg']}');
      }
    } catch (e) {
      print('Error during blog category deletion: $e');
      throw e;
    }
  }
}
