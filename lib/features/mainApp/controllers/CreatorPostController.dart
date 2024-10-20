import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:junorno_news/features/mainApp/screens/ChannelProfile.dart';
import 'dart:convert';

import '../../../constants/colors.dart';
import '../models/CreatorPostModel.dart';

class CreatorPostController extends GetxController {
  var isLoading = true.obs;
  var postList = <CreatorModelPost>[].obs;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    String? userId = await storage.read(key: "channel_id");
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://blog-app-server-4fcmc8ww2-ameeq-ahmads-projects.vercel.app/user/$userId/blogpost'));
      if (response.statusCode == 200) {
        var posts = json.decode(response.body) as List;
        postList.value = posts.map((post) => CreatorModelPost.fromJson(post)).toList();
      } else {
        Get.snackbar("Error", "Failed to load posts");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> deletePost(String postId) async {
    String? userId = await storage.read(key: "channel_id");
    try {
      isLoading(true);
      final response = await http.delete(
        Uri.parse('https://blog-app-server-69zt55hi0-ameeq-ahmads-projects.vercel.app/user/$userId/blogpost/$postId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        postList.removeWhere((post) => post.id == postId);
        Get.snackbar("Success", "Post deleted successfully");
      } else {
        Get.snackbar("Error", "Failed to delete post");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Show Confirm Dialog
  void confirmDelete(String postId) {
    Get.defaultDialog(
      title: "Delete Post",
      middleText: "Are you sure you want to delete this post?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: TColors.white,
      onConfirm: () {
        deletePost(postId);
        Get.to(ChannelProfileScreen());
      },
      onCancel: () => Get.to(ChannelProfileScreen()), // Just close the dialog
    );
  }
}


