import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/UserPostsModel.dart';

class UserSearchController {
  final String apiUrl = 'https://blog-app-server-p83w1edot-ameeq-ahmads-projects.vercel.app/user'; // Replace with your actual API URL

  // Method to fetch posts by search query
  Future<List<UserPostsModel>> searchPosts(String title) async {
    final url = Uri.parse('$apiUrl/search?title=$title');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((json) => UserPostsModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('No posts found');
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
