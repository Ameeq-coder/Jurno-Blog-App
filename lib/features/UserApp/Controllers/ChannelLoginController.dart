import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:junorno_news/features/UserApp/Models/ChannelLoginModel.dart';
import 'package:http/http.dart' as http;

import '../../mainApp/screens/creatorhome.dart';

class Channellogincontroller {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final String loginurl =
      'https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/channel/login';


  Future<void> loginchannel(ChannelLoginModel channel) async{
    try{
      final response=await http.post(
        Uri.parse(loginurl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(channel.toJson()),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Store the channel ID securely
        await _secureStorage.write(key: 'channel_id', value: responseData['channelId']);
        Get.snackbar('Success', 'Channel logged in successfully');

        // You can navigate to the creator home screen upon successful login
        Get.offAll(() => HomeScreen());
      } else if (response.statusCode == 400) {
        throw Exception('Invalid credentials');
      } else {
        throw Exception('Channel not found');
      }
    }catch(e){
      Get.snackbar('Error', e.toString());
    }


  }



}
