import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/mainApp/controllers/BlogCategoryController.dart';
import 'package:junorno_news/features/mainApp/models/BlogCategoryModel.dart';
import 'package:junorno_news/features/mainApp/screens/AddBlogCategoryScreen.dart';
import 'package:junorno_news/features/mainApp/screens/UpdateBlogCategoryScreen.dart';
import 'package:junorno_news/features/mainApp/screens/widgets/BlogCategoryCard.dart';
import 'package:junorno_news/features/mainApp/screens/widgets/bottomnavigation.dart';

import '../controllers/DeleteBlogCategoryController.dart';

class BlogCategoryManagementScreen extends StatefulWidget {
  final String userId;

  BlogCategoryManagementScreen({required this.userId});

  @override
  _BlogCategoryManagementScreenState createState() => _BlogCategoryManagementScreenState();
}

class _BlogCategoryManagementScreenState extends State<BlogCategoryManagementScreen> {

  late Future<List<BlogCategoryModel>> _blogCategoriesFuture;
  late BlogCategoryController _blogCategoryControllerInstance;
  late DeleteBlogCategoryController _deleteBlogCategoryControllerInstance;


  @override
  void initState() {
    super.initState();
    _blogCategoryControllerInstance = BlogCategoryController(widget.userId);
    _blogCategoriesFuture = _blogCategoryControllerInstance.fetchBlogCategories();
    _deleteBlogCategoryControllerInstance = DeleteBlogCategoryController();

  }

  void _refreshBlogCategories() {
    setState(() {
      _blogCategoriesFuture = _blogCategoryControllerInstance.fetchBlogCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: TColors.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => Get.to(() => AddBlogCategoryScreen(
              onBlogCategoryAdded: _refreshBlogCategories,
            )),
          ),
        ],
      ),
      body: FutureBuilder<List<BlogCategoryModel>>(
        future: _blogCategoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No blog categories available.'));
          } else {
            final blogCategories = snapshot.data!;
            return ListView.builder(
              itemCount: blogCategories.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: BlogCategoryCard(
                    blogCategoryModel: blogCategories[index],
                    index: index,
                    onEdit: () {
                      Get.to(() => UpdateBlogCategoryScreen(
                        oldSlug: blogCategories[index].slug,
                        oldBlogCategory: blogCategories[index].blogcategory,
                      ))!.then((_) => _refreshBlogCategories());
                    },
                    onDelete: () async {
                           try {
                        bool success = await _deleteBlogCategoryControllerInstance.deleteBlogCategory(blogCategories[index].blogcategory);
                        if (success) {
                          _refreshBlogCategories();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Blog category deleted successfully'))
                          );
                        }
                      } catch (e) {
                             ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text(
                                     'Failed to delete blog category: $e'))
                             );
                           }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBarWidget(currentIndex: 3),  // Use the widget here
    );
  }
}
