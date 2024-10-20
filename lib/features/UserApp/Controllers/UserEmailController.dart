import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:junorno_news/features/UserApp/Models/UserEmail.dart';

class UserEmailController extends GetxController {
  var userEmail = ''.obs;
  var isLoading = true.obs;

  FlutterSecureStorage storage=FlutterSecureStorage();

  Future<void> fetchUserEmail() async {
    String? userId= await storage.read(key: 'user_id');
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/email'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        UserEmail user = UserEmail.fromJson(jsonData);
        userEmail.value = user.email;
      } else {
        Get.snackbar('Error', 'Failed to fetch user email');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
