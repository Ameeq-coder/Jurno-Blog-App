import 'package:junorno_news/features/mainApp/models/TagModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Tagcontroller{
  final String userId;

  Tagcontroller(this.userId){
    print("User ID passed to Tagcontroller: $userId"); // Debug print
  }

  Future<List<TagModel>> fetchTags() async {
    try {
      final String apiUrl = 'https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/tags';
      final response = await http.get(
          Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> tagsJson = json.decode(response.body)['tags'];
        return tagsJson.map((json) => TagModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tags: ${response.statusCode}');
      }
    }catch(e){
      print(userId);
      throw Exception('hell: $e');
    }

  }

}