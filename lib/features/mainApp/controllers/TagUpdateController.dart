import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:junorno_news/features/mainApp/models/UpdateTagModel.dart';

class TagUpdateController {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<bool> updateTag(UpdateTagModel updateTagModel) async {
    try {
      String? userId = await storage.read(key: "channel_id");
      if (userId == null) {
        throw Exception("User ID not found");
      }else{
        print("Id Found");
      }

      final String apiUrl = 'https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/tags';
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updateTagModel.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update tag: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during tag update: $e');
      throw e;
    }
  }
}
