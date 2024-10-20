import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:junorno_news/features/mainApp/models/UpdateBlogCategoryModel.dart';

class BlogCategoryUpdateController {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<bool> updateBlogCategory(UpdateBlogCategoryModel updateModel) async {
    try {
      String? userId = await storage.read(key: "channel_id");
      if (userId == null) {
        throw Exception("User ID not found");
      } else {
        print("Id Found");
      }

      final String apiUrl = 'https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/blogcategories';
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updateModel.toJson()),
      );

      if (response.statusCode == 200) {
        // Optionally handle response data here if needed
        final responseData = jsonDecode(response.body);
        print('Update successful: ${responseData['msg']}');
        return true;
      } else {
        throw Exception('Failed to update blog category: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during blog category update: $e');
      throw e;
    }
  }
}
