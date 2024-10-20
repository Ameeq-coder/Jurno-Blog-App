import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/PostCard.dart';
import '../../../constants/colors.dart';
import '../Controllers/FavoriteController.dart';
import '../widgets/Userbottomnavigation.dart';
import 'UserPostContent.dart';
import 'UserProfile.dart';


class UserFavorites extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());


  @override
  Widget build(BuildContext context) {
    favoriteController.fetchFavorites();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  height: 100,
                  width: 100,
                  'assets/images/logouserhome.png',
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(UserProfileScreen());
                  },
                  child: CircleAvatar(
                    child: Image.asset('assets/images/profile.png'),
                    radius: 20,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 120,
            left: 16,
            child: Text(
              'Favorites',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
              ),
            ),
          ),
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            bottom: 0,
            child: Obx(() {
              if (favoriteController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (favoriteController.favorites.isEmpty) {
                return Center(child: Text('No favorites found'));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: favoriteController.favorites.length,
                  itemBuilder: (context, index) {
                    var post = favoriteController.favorites[index];
                    return PostCard(
                      id: post.id,
                      imageUrl: post.imageUrl,
                      title: post.title,
                      date:"Favorites",
                      onPressed: () {
                        Get.to(() => PostScreen(postId: post.id));
                      },
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: UserBottomNavBarWidget(currentIndex: 3), // Add BottomNavigationBar here
    );
  }
}
