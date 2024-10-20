import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/mainApp/controllers/ChannelImageController.dart';
import 'package:junorno_news/features/mainApp/screens/ChannelLogin.dart';
import 'package:junorno_news/features/mainApp/screens/UpdatePostScreen.dart';
import 'package:junorno_news/features/mainApp/screens/widgets/bottomnavigation.dart';

import '../../UserApp/Screens/userhome.dart';
import '../controllers/ChannelNameController.dart';
import '../controllers/CreatorPostController.dart';

class ChannelProfileScreen extends StatelessWidget {

  FlutterSecureStorage storage=FlutterSecureStorage();

  final ChannelNameController _channelController =
      Get.put(ChannelNameController());

  final ChannelImageController _channelImageController =
      Get.put(ChannelImageController());

  final CreatorPostController _creatorPostController =
      Get.put(CreatorPostController());

  @override
  Widget build(BuildContext context) {
    _channelController.fetchChannel();

    _channelImageController.ImagefetchChannel();

    _creatorPostController.fetchPosts();

    return Scaffold(body: Obx(() {
      if (_channelController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(UserHome());
                        },
                        icon: Icon(Icons.switch_account, color: Colors.white),
                      ),
                      SizedBox(height: 5), // Add spacing between icon and text
                      Text(
                        "Switch Account",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: Column(
                    children: [
                      IconButton(onPressed: (){
                        Get.to(Channellogin());
                        storage.delete(key: 'channel_id');
                      }, icon: Icon(Icons.logout, color: Colors.white)),
                      SizedBox(height: 5), // Add spacing between icon and text
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _channelImageController
                                    .channel.value.channelImage !=
                                null
                            ? NetworkImage(_channelImageController
                                .channel.value.channelImage!)
                            : AssetImage('assets/images/profile.png')
                                as ImageProvider,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        // here the name where i want
                        _channelController.channel.value.channelName,
                        // Display the channel name from API
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          _channelImageController
                                  .channel.value.channelDescription ??
                              'No description available',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

            ),
            SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'My Posts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() {
                if (_creatorPostController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (_creatorPostController.postList.isEmpty) {
                  return Center(child: Text('No posts found'));
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
                  itemCount: _creatorPostController.postList.length,
                  itemBuilder: (context, index) {
                    final post = _creatorPostController.postList[index];
                    return ChannelPostCard(
                      title: post.title,
                      imageUrl: post.image,
                      postId: post.id,
                    );
                  },
                );
              }),
            )

            // Posts Grid
          ],
        ),
      );
    }),
      bottomNavigationBar:  BottomNavBarWidget(currentIndex: 4),

    );

  }
}

class ChannelPostCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String postId; // Add postId field

  final CreatorPostController _creatorPostController =
      Get.put(CreatorPostController());

  ChannelPostCard({
    required this.title,
    required this.imageUrl,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image section with a fixed size
          SizedBox(
            height: 150,
            width: double.infinity,
            // Set the height of the image as per your requirement
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
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
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Get.to(UpdatePostScreen(postId: postId));
                  },
                ),
                // Icon section
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _creatorPostController.confirmDelete(postId);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
