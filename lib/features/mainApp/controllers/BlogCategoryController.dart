import 'package:junorno_news/features/mainApp/models/BlogCategoryModel.dart'; // Update the import to BlogCategoryModel
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlogCategoryController {
  final String userId;

  BlogCategoryController(this.userId) {
    print("User ID passed to BlogCategoryController: $userId"); // Debug print
  }

  Future<List<BlogCategoryModel>> fetchBlogCategories() async {
    try {
      final String apiUrl = 'https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/blogcategories';
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> blogCategoriesJson = json.decode(response.body)['blogcategories'];
        return blogCategoriesJson.map((json) => BlogCategoryModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load blog categories: ${response.statusCode}');
      }
    } catch (e) {
      print(userId);
      throw Exception('Error: $e');
    }
  }
}
