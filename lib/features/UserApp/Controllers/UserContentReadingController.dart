import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Models/UserContentReadingModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class UserContentPostController {

  // Fetch post details
  Future<UserContentReadingModel?> fetchPost(String postId) async {
    final url = 'https://blog-app-server-c71qy3p66-ameeq-ahmads-projects.vercel.app/user/post/$postId'; // Replace with your API URL

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response and return a PostModel
        final Map<String, dynamic> postJson = json.decode(response.body);
        return UserContentReadingModel.fromJson(postJson);
      } else {
        print('Failed to load post. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching post: $e');
      return null;
    }
  }

  // Increment post view count
  Future<void> incrementPostView(String postId) async {
    final url = 'https://blog-app-server-c71qy3p66-ameeq-ahmads-projects.vercel.app/user/post/$postId/view';

    try {
      final response = await http.post(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Failed to increment views. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error incrementing post views: $e');
      throw Exception('Error incrementing views: $e');
    }
  }

  Future<void> addPostToFavorites(String postId) async {

    final storage = FlutterSecureStorage();
    String? userId = await storage.read(key: "user_id");


    final response = await http.post(
        Uri.parse('https://blog-app-server-p83w1edot-ameeq-ahmads-projects.vercel.app/user/$userId/favorites/$postId')
    );

    if (response.statusCode == 200) {
      print('Post added to favorites');
    } else {
      print('Failed to add post to favorites');
    }
  }

  Future<void> downloadPost(String postId) async {

    final storage = FlutterSecureStorage();

    try{
      String? userId = await storage.read(key: "user_id");
      if(userId==null){
        throw Exception("User not logged in");
      }

      final url = 'https://blog-app-server-c71qy3p66-ameeq-ahmads-projects.vercel.app/user/download/$postId/$userId';

      final response = await http.get(Uri.parse(url));

      if(response.statusCode==200){
        Directory dir = await getApplicationDocumentsDirectory();
        String filePath = '${dir.path}/$postId.pdf';

        // Write the PDF file to the device storage
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Open the file using any PDF viewer app
        OpenFile.open(filePath);
      }
      else {
        throw Exception("Failed to download post");
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }


    }

  Future<void> removePostFromFavorites(String postId) async {

    final storage = FlutterSecureStorage();


    final userId = await storage.read(key: 'user_id'); // Fetch user_id from secure storage
    final url = 'https://blog-app-server-p83w1edot-ameeq-ahmads-projects.vercel.app/user/$userId/favorites/$postId';

    final response = await http.delete(Uri.parse(url)); // DELETE request to remove from favorites

    if (response.statusCode != 200) {
      throw Exception('Failed to remove post from favorites');
    }
  }


  }


