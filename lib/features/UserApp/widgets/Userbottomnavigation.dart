import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/mainApp/screens/AddPostScreen.dart';
import 'package:junorno_news/features/mainApp/screens/BlogCategoryManagementScreen.dart';
import 'package:junorno_news/features/mainApp/screens/TagsScreen.dart';


import '../../mainApp/screens/ChannelSignup.dart';
import '../../mainApp/screens/creatorhome.dart';
import '../Screens/UserProfile.dart';
import '../Screens/userdownload.dart';
import '../Screens/userfavorties.dart';
import '../Screens/userhome.dart';

class UserBottomNavBarWidget extends StatelessWidget {
  final int currentIndex;

  UserBottomNavBarWidget({required this.currentIndex});

  Future<void> _onBottomNavItemTapped(int index, BuildContext context) async {
    final storage = FlutterSecureStorage();
    switch (index) {
      case 0:
        Get.to(() => UserHome());
        break;
      case 1:
        Get.to(()=>UserDownload());
        break;
      case 2:
        FlutterSecureStorage storage=FlutterSecureStorage();
        String? CurrentChannel= await storage.read(key: 'channel_id');
        if(CurrentChannel==null){
          Get.to(() => Channelsignup());
        }else{
         Get.to(HomeScreen());
        }
        break;
      case 3:
          Get.to(() => UserFavorites());
        break;
      case 4:
        Get.to(() => UserProfileScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.download),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle, size: 40, color: TColors.primary),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
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
