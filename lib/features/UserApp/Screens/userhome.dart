import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/UserApp/Controllers/UserPostsController.dart';
import 'package:junorno_news/features/UserApp/Controllers/UserSearchController.dart';
import 'package:junorno_news/features/UserApp/Models/UserPostsModel.dart';
import 'package:junorno_news/features/UserApp/Screens/UserProfile.dart';
import '../Controllers/UserCategoryController.dart';
import '../Models/UserCategoryModel.dart';
import '../../../common/widgets/CategoryButton.dart';
import '../../../common/widgets/PostCard.dart';
import 'package:get/get.dart';

import '../widgets/Userbottomnavigation.dart';
import 'UserPostContent.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final UserCategoryController _categoryController = UserCategoryController();
  final UserPostController _postController = UserPostController();
  final UserSearchController _searchController = UserSearchController();

  List<UserPostsModel> _posts = [];
  String _selectedCategory = '';
  String _searchQuery = '';

  // Fetch posts based on the search query
  void _searchPosts(String title) async {
    try {
      List<UserPostsModel> posts = await _searchController.searchPosts(title);

      setState(() {
        _posts = posts; // Update posts list after search
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _posts = []; // Clear posts if there's an error or no posts found
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top AppBar Section with Menu Icon and Profile
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

          // Search Bar Section
          Positioned(
            top: 90,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      onFieldSubmitted: (query) {
                        setState(() {
                          _searchQuery = query;
                        });
                        _searchPosts(_searchQuery); // Trigger search on submit
                      },
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Category Button Row
          Positioned(
            top: 160,
            left: 16,
            right: 16,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder<List<UserCategoryModel>>(
                future: _categoryController.fetchUserCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No categories available');
                  }

                  List<UserCategoryModel> categories = snapshot.data!;

                  // Preselect the first category if no category is selected
                  if (_selectedCategory.isEmpty && categories.isNotEmpty) {
                    _selectedCategory = categories.first.name;
                    _fetchPostsByCategory(_selectedCategory); // Fetch posts for the first category
                  }

                  return Row(
                    children: categories.map((category) {
                      bool isSelected = _selectedCategory == category.name;

                      return CategoryButton(
                        label: category.name,
                        selected: isSelected,
                        onPressed: () {
                          setState(() {
                            _selectedCategory = category.name;
                            _fetchPostsByCategory(_selectedCategory); // Fetch posts by category
                          });
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),

          // GridView with Post Cards
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _posts.isEmpty
                  ? Center(child: Text('No posts available for this category or search query')) // Adjusted message
                  : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  UserPostsModel post = _posts[index];
                  return PostCard(
                    id: post.id,
                    imageUrl: post.imageUrl ?? 'default_image_url.png',
                    title: post.title,
                    date: post.formattedDate,
                    onPressed: () {
                      Get.to(() => PostScreen(postId: post.id)); // Ensure correct postId is passed
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: UserBottomNavBarWidget(currentIndex: 0), // Add BottomNavigationBar here
    );
  }

  // Fetch posts by selected category
  void _fetchPostsByCategory(String category) async {
    try {
      List<UserPostsModel> posts =
      await _postController.fetchPostsByCategory(category);
      setState(() {
        _posts = posts; // Update posts list by category
      });
    } catch (e) {
      print('Failed to fetch posts: $e');
    }
  }
}
