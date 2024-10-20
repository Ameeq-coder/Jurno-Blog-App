import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/mainApp/controllers/AddBlogCategoryController.dart';
import 'package:junorno_news/features/mainApp/models/BlogCategoryAddModel.dart';

class AddBlogCategoryScreen extends StatelessWidget {

  final VoidCallback onBlogCategoryAdded;

  final TextEditingController blogCategoryController = TextEditingController();
  final TextEditingController slugController = TextEditingController();
  final AddBlogCategoryController blogCategoryControllerInstance = AddBlogCategoryController();

  AddBlogCategoryScreen({super.key, required this.onBlogCategoryAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set white background for the entire screen
      appBar: AppBar(
        backgroundColor: Colors.orange, // Orange color for AppBar only
        elevation: 0,
        title: Text(
          'Add New Blog Category',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // This centers the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Column(
              children: [
                TextField(
                  controller: blogCategoryController,
                  decoration: InputDecoration(
                    labelText: 'Blog Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: slugController,
                  decoration: InputDecoration(
                    labelText: 'Slug',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String blogCategory = blogCategoryController.text.trim();
                  String slug = slugController.text.trim();

                  bool success = await blogCategoryControllerInstance.addBlogCategory(blogCategory, slug);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Blog category and slug added/updated successfully'),
                    ));
                    onBlogCategoryAdded(); // Trigger the callback to refresh blog categories
                    Navigator.pop(context); // Navigate back
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to add/update blog category and slug'),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.orange, // Orange button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
