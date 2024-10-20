import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:junorno_news/features/mainApp/models/PostModel.dart';
import 'dart:convert';

class PostController {
  final storage = FlutterSecureStorage();

  // Function to add a new post using the Post model
  Future<bool> addPost(PostModel post, File? featuredImage) async {
    try {
      // Fetch the userId from secure storage
      String? userId = await storage.read(key: "channel_id");
      if (userId == null) {
        throw Exception("User ID not found");
      }

      // Construct the URL
      final String url = "https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/blogpost";
      final apiUrl = Uri.parse(url);

      // Prepare a multipart request
      var request = http.MultipartRequest('POST', apiUrl);

      Map<String, String> postFields = post.toMap().map(
            (key, value) => MapEntry(key, value.toString()), // Convert each value to a string
      );

      // Add post fields to the request from the Post model
      request.fields.addAll(postFields);

      // Attach the featured image if it's provided
      if (featuredImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'featuredImage',
          featuredImage.path,
        ));
      }else{
        return false;
      }
      var response = await request.send();

      if (response.statusCode == 201) {
        // Success
        return true;
      } else {
        // Error - read the response body
        var responseBody = await response.stream.bytesToString();
        var responseData = jsonDecode(responseBody);
        print('Failed to add post: ${responseData['msg']}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }


    }
