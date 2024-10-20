import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junorno_news/constants/colors.dart';
import '../../../common/widgets/PostCard.dart';
import '../Controllers/DownloadController.dart';
import '../widgets/Userbottomnavigation.dart';
import 'UserPostContent.dart';
import 'UserProfile.dart';

class UserDownload extends StatelessWidget {
  final DownloadController downloadController = Get.put(DownloadController());


  @override
  Widget build(BuildContext context) {
    downloadController.fetchDownloads();  // Fetch downloads when screen opens

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top AppBar Section with Logo and Profile
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

          // "Downloads" Heading Section
          Positioned(
            top: 120,  // Adjust the position to be below the app bar
            left: 16,
            child: Text(
              'Downloads',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
              ),
            ),
          ),

          // GridView with Post Cards
          Positioned(
            top: 160,  // Adjusted the top position to be below the "Downloads" heading
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                if (downloadController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());  // Show loading indicator
                }
                if (downloadController.downloads.isEmpty) {
                  return Center(child: Text('No downloads found.'));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: downloadController.downloads.length,
                  itemBuilder: (context, index) {
                    final download = downloadController.downloads[index];
                    return PostCard(
                      id: download.id,
                      imageUrl: download.imageUrl,
                      title: download.title,
                      date: download.formattedDate,
                      onPressed: () {
                        Get.to(() => PostScreen(postId: download.id));  // Navigate to post content
                      },
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: UserBottomNavBarWidget(currentIndex: 1), // Add BottomNavigationBar here
    );
  }
}
