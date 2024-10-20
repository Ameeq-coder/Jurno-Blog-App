import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:junorno_news/features/UserApp/Models/FavortiesModel.dart';
import 'dart:convert';

class FavoriteController extends GetxController {
  var isLoading = true.obs;
  var favorites = <FavoriteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchFavorites() async {
    final storage = FlutterSecureStorage();
    String? userId = await storage.read(key: "user_id");

    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://blog-app-server-p83w1edot-ameeq-ahmads-projects.vercel.app/user/$userId/favorites'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var favoritesList = data['favorites'] as List;
        favorites.value = favoritesList.map((post) => FavoriteModel.fromJson(post)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch favorites');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
