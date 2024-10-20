import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/DownloadModel.dart';

class DownloadController extends GetxController {
  var downloads = <DownloadModel>[].obs;  // Reactive list of downloaded posts
  var isLoading = true.obs;

  // Function to fetch downloaded posts
  Future<void> fetchDownloads() async {

    final storage = FlutterSecureStorage();
    String? userId = await storage.read(key: "user_id");
    try {
      isLoading(true);
      var url = Uri.parse('https://blog-app-server-p83w1edot-ameeq-ahmads-projects.vercel.app/user/$userId/downloads');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['downloads'];
        downloads.value = jsonResponse
            .map((download) => DownloadModel.fromJson(download))
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to load downloads');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
