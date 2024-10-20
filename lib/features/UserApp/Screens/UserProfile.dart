import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:get/get.dart';
import 'package:junorno_news/features/UserApp/Screens/UserPostContent.dart';
import 'package:junorno_news/features/UserApp/widgets/Userbottomnavigation.dart';
import 'package:junorno_news/features/authentication/screens/Front%20Screen/front.dart';
import 'package:junorno_news/features/mainApp/screens/widgets/bottomnavigation.dart';

import '../Controllers/UserEmailController.dart'; // Import the user email controller
import '../Controllers/FavoriteController.dart'; // Import the favorites controller

class UserProfileScreen extends StatelessWidget {
  final UserEmailController userController = Get.put(UserEmailController());
  final FavoriteController favoriteController = Get.put(FavoriteController()); // Add favorite controller

  FlutterSecureStorage _storage= FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    // Fetch user email and favorites when screen is built
    userController.fetchUserEmail();
    favoriteController.fetchFavorites(); // Fetch favorites when the screen is built

    return Scaffold(
      body: Obx(() {
        if (userController.isLoading.value || favoriteController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    height: 270,
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 40,
                  //   left: 20,
                  //   child: IconButton(
                  //     icon: Icon(Icons.arrow_back, color: Colors.white),
                  //     onPressed: () {
                  //       // Back button logic here
                  //     },
                  //   ),
                  // ),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: IconButton(
                        onPressed: () {
                          _storage.delete(key: 'user_id');
                          Get.to(() => front()); // Ensure correct postId is passed
                        }, icon: Icon(Icons.logout, color: Colors.white)),
                  ),
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/profile.png'),
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          userController.userEmail.value, // Display the fetched email
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'My Favorites',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(() {
                  // Check if favorites are loading or not
                  if (favoriteController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 17,
                      mainAxisSpacing: 14,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: favoriteController.favorites.length, // Count of favorite items
                    itemBuilder: (context, index) {
                      var post=favoriteController.favorites[index];
                      // Pass each favorite item to the card
                      return UserPostCard(
                        favorite: post,
                        onPressed: () {
                          print("Navigating to Post ID: ${post.id}"); // Log post ID
                          Get.to(PostScreen(postId: post.id));
                        },
                        id: post.id,
                      );

                    },
                  );
                }),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: UserBottomNavBarWidget(currentIndex: 4),
    );
  }
}

class UserPostCard extends StatelessWidget {
  String id;
  final favorite; // The favorite item passed from the controller
  final VoidCallback onPressed; // Add a callback for when the card is pressed

  UserPostCard({required this.id,required this.favorite,required this.onPressed});
 // Constructor to accept the favorite item
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image section with a fixed size
          SizedBox(
            height: 150,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                favorite.imageUrl, // Use favorite's imageUrl
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('', fit: BoxFit.cover); // Fallback image
                },
              ),
            ),
          ),
          // Title and icon section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title section
                Expanded(
                  child: Text(
                    favorite.title, // Use favorite's title
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
