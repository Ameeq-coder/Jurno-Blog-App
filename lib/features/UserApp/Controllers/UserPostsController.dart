import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:junorno_news/features/UserApp/Models/UserPostsModel.dart';



class UserPostController {


  // Fetch posts by category
  Future<List<UserPostsModel>> fetchPostsByCategory(String category) async {
    final String apiUrl = 'https://blog-app-server-60pijkifb-ameeq-ahmads-projects.vercel.app/user/posts/category/$category';


    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<UserPostsModel> posts = body.map((dynamic item) => UserPostsModel.fromJson(item)).toList();
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
