import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryController {
  Future<bool> updateCategories(String userId, List<String> categories) async {
    final url = 'https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/categories';

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'categories': categories,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update categories: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
