import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/mainApp/screens/AddPostScreen.dart';
import 'package:junorno_news/features/mainApp/screens/BlogCategoryManagementScreen.dart';
import 'package:junorno_news/features/mainApp/screens/ChannelProfile.dart';
import 'package:junorno_news/features/mainApp/screens/TagsScreen.dart';


import '../creatorhome.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;

  BottomNavBarWidget({required this.currentIndex});

  Future<void> _onBottomNavItemTapped(int index, BuildContext context) async {
    final storage = FlutterSecureStorage();
    switch (index) {
      case 0:
        Get.to(() => HomeScreen());
        break;
      case 1:
        String? userId = await storage.read(key: 'channel_id');
        if (userId != null) {
          Get.to(() => TagManagementScreen(userId: userId));
        } else {
          print("User ID not found");
        }
        break;
      case 2:
        Get.to(() => AddPostScreen(selectedTags: [], selectedCategories: []));
        break;
      case 3:
        String? userId = await storage.read(key: 'channel_id');
        if (userId != null) {
          Get.to(() => BlogCategoryManagementScreen(userId: userId));
        } else {
          print("User ID not found");
        }
        break;
      case 4:
        Get.to(() => ChannelProfileScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tag_sharp),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle, size: 40, color: TColors.primary),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: '',
        ),
      ],
      selectedItemColor: TColors.primary,
      unselectedItemColor: TColors.warning,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) => _onBottomNavItemTapped(index, context),
    );
  }
}
