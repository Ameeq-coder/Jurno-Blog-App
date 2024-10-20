import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Addtagcontroller{



  final Storage= FlutterSecureStorage();

  Future<bool> addTag(String tag, String slug) async {
    try {
      String? userId =await Storage.read(key: "channel_id");
      if(userId==null){
        throw Exception("User Id not found");
      }
      final String url="https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/tags";
      final apiurl = Uri.parse(url);
      final response = await http.post(
        apiurl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'tag': tag,
          'slug': slug,
        }),
      );

      if(response.statusCode==200){
        final responsedata= jsonDecode(response.body);
        return true;
      }else{
        return false;
      }

    }catch(e){
      print('Error: $e');
      return false;
    }
 

  }


}
