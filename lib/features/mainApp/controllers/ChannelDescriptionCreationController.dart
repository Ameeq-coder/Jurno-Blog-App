import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/ChannelDescriptionCreationModel.dart';
import '../screens/creatorhome.dart';

class ChannelDescriptionCreationController extends GetxController {
  var isLoading = false.obs;
  var channel = ChannelDescriptionCreationModel().obs;

  Future<void> updateChannel(String description, File? image) async {

    FlutterSecureStorage storage=FlutterSecureStorage();
    String? UserId = await storage.read(key: 'channel_id');


    isLoading(true);
    try {
      var request = http.MultipartRequest('POST', Uri.parse('https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$UserId/channel'));
      request.fields['channelDescription'] = description;

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('channelImage', image.path));
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        var res = await http.Response.fromStream(response);
        var data = json.decode(res.body);
        channel.value = ChannelDescriptionCreationModel.fromJson(data['user']);
        Get.snackbar('Success', 'Channel updated successfully!');
        Get.offAll(() => HomeScreen());

      } else {
        Get.snackbar('Error', 'Failed to update channel');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
