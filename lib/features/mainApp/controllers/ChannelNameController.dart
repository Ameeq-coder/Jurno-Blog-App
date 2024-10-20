import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:junorno_news/features/mainApp/models/ChannelNameModel.dart';

class ChannelNameController extends GetxController {
  var channel = ChannelNameModel(channelName: "").obs;
  var isLoading = false.obs;

  Future<void> fetchChannel() async {
    FlutterSecureStorage storage=FlutterSecureStorage();
    String? channelId = await storage.read(key: 'channel_id');

    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/channel/$channelId'));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        channel.value = ChannelNameModel.fromJson(jsonResponse);
      } else {
        Get.snackbar("Error", "Failed to load channel");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
