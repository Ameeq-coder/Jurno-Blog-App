import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:junorno_news/features/mainApp/models/UpdatePostModel.dart';

class UpdatePostController extends GetxController {
  Future<UpdatePostModel?> getPostById(String postId) async {
    try {
      final response = await http.get(Uri.parse('https://blog-app-server-69zt55hi0-ameeq-ahmads-projects.vercel.app/user/post/$postId'));
      if (response.statusCode == 200) {
        return UpdatePostModel.fromJson(jsonDecode(response.body));
      } else {
        print("Error fetching post: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching post: $e");
      return null;
    }
  }


  Future<bool> updatePost(
      String postId,
      UpdatePostModel postData,
      File? imageFile,  // Image file is nullable
      ) async {
    final FlutterSecureStorage storage = FlutterSecureStorage();

    String? userId = await storage.read(key: 'channel_id');

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('https://blog-app-server-dide8gtxi-ameeq-ahmads-projects.vercel.app/user/$userId/blogpost/$postId'),
    );

    // Add text fields for post data
    request.fields['title'] = postData.title ?? '';
    request.fields['slug'] = postData.slug ?? '';
    request.fields['categories'] = postData.categories?.join(',') ?? '';
    request.fields['tags'] = postData.tags?.join(',') ?? '';
    request.fields['content'] = postData.content ?? '';

    // Upload image if available
    if (imageFile != null) {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile(
        'featuredImage',
        stream,
        length,
        filename: imageFile.path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    // Send request
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Post updated successfully with image');
      return true;
    } else {
      print('Error updating post: ${response.statusCode}');
      return false;
    }
  }
}













