import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Models/ChannelSignupModel.dart';
import 'package:http/http.dart' as http;

class ChannelSignupController{
  final FlutterSecureStorage _secureStorage= FlutterSecureStorage();

  final String signupUrl = 'https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/channels/signup'; // Replace with your actual API URL



  Future<String?> signUpChannel(ChannelSignupModel channel) async {
    try {
      final response = await http.post(
        Uri.parse(signupUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(channel.toJson()),
      );

      if (response.statusCode == 201) {
        // Successfully created the channel, store the channelId
        final responseData = jsonDecode(response.body);
        final channelId = responseData['channelId'];

        // Save the channelId to secure storage
        await _secureStorage.write(key: 'channel_id', value: channelId);

        return channelId;
      } else if (response.statusCode == 400) {
        throw Exception('Channel name already exists');
      } else {
        throw Exception('Failed to create channel');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }





}