import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DelteTagController{


  final Storage= FlutterSecureStorage();
  Future<bool> deleteTag(String tag) async {
    String? userId =await Storage.read(key: "channel_id");
    if(userId==null){
      throw Exception("User Id not found");
    }else{
      final url='https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/tags';
      final apiurl=Uri.parse(url);
      final response = await http.delete(
        apiurl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'tag': tag}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete tag: ${jsonDecode(response.body)['msg']}');
      }
    }





  }



}