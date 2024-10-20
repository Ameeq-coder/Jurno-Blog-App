import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Controllers/UserContentReadingController.dart';
import '../Models/UserContentReadingModel.dart';
import 'package:intl/intl.dart';

class PostScreen extends StatefulWidget {
  final String postId;

  const PostScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final UserContentPostController postController = UserContentPostController();
  ValueNotifier<bool> isFavorited = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    // Increment views when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      postController.incrementPostView(widget.postId);
    });
  }

  @override
  void dispose() {
    isFavorited.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder<UserContentReadingModel?>(
        future: postController.fetchPost(widget.postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching post data"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("Post not found"));
          } else {
            UserContentReadingModel post = snapshot.data!;
            String formattedDate = DateFormat('dd MMM yyyy').format(post.date);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(post.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.person, size: 16, color: Colors.white),
                                SizedBox(width: 5),
                                Text(post.channelName, style: TextStyle(color: Colors.white)),
                                SizedBox(width: 10),
                                Icon(Icons.calendar_today, size: 16, color: Colors.white),
                                SizedBox(width: 5),
                                Text(formattedDate, style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: isFavorited,
                          builder: (context, value, child) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 2,
                              color: Colors.white,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    value
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: value ? Colors.red : Colors.black,
                                  ),
                                  iconSize: 25,
                                  onPressed: () async {
                                    if (value) {
                                      // Remove from favorites
                                      await postController.removePostFromFavorites(widget.postId);
                                      isFavorited.value = false;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Post removed from favorites')),
                                      );
                                    } else {
                                      // Add to favorites
                                      await postController.addPostToFavorites(widget.postId);
                                      isFavorited.value = true;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Post added to favorites')),
                                      );
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 10),
                        // Add your other buttons here (e.g., Download, Share)
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25), // Circular card
                          ),
                          elevation: 2,
                          color: Colors.white, // Set the card background color to white
                          child: Container(
                            width: 40, // Set card width
                            height: 40, // Set card height
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.download, color: Colors.black),
                              iconSize: 25, // Adjust icon size
                              onPressed: () async {
                                try {
                                  await postController.downloadPost(widget.postId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Post downloaded successfully'))
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Failed to download post $e'))
                                  );
                                }
                                // Handle Saved button press
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        // Card(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(25), // Circular card
                        //   ),
                        //   elevation: 2,
                        //   color: Colors.white, // Set the card background color to white
                        //   child: Container(
                        //     width: 40, // Set card width
                        //     height: 40, // Set card height
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: Colors.white.withOpacity(0.7),
                        //     ),
                        //     child: IconButton(
                        //       icon: Icon(Icons.share, color: Colors.black),
                        //       iconSize: 25, // Adjust icon size
                        //       onPressed: () {
                        //         // Handle Share button press
                        //       },
                        //     ),
                        //   ),
                        // ),
                        // Other buttons (saved, share)...


                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.content,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
