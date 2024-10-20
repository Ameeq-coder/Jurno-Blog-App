import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:junorno_news/features/mainApp/models/ChannelImageModel.dart';
import 'dart:convert';


class ChannelImageController extends GetxController {
  var channel = ChannelImageModel().obs; // Observes changes to the channel
  var isLoading = true.obs;

  // Fetch the channel details by userId
  Future<void> ImagefetchChannel() async {

    FlutterSecureStorage storage=FlutterSecureStorage();
    String? UserId = await storage.read(key: 'channel_id');

    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$UserId/channel'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        channel.value = ChannelImageModel.fromJson(data);
      } else {
        Get.snackbar('Error', 'Failed to fetch channel data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
