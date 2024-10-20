import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junorno_news/features/mainApp/controllers/UpdateBlogController.dart';
import 'package:junorno_news/features/mainApp/models/UpdateBlogCategoryModel.dart';
import '../../../utils/constants/colors.dart';

class UpdateBlogCategoryScreen extends StatelessWidget {
  final String oldBlogCategory;
  final String oldSlug;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController slugController = TextEditingController();
  final BlogCategoryUpdateController blogCategoryUpdateController = BlogCategoryUpdateController();

  UpdateBlogCategoryScreen({required this.oldBlogCategory, required this.oldSlug}) {
    // Pre-fill the text fields with the old category and slug
    titleController.text = oldBlogCategory;
    slugController.text = oldSlug;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                  color: TColors.primary,
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: AppBar(
                    backgroundColor: Colors.orange,
                    elevation: 0,
                    title: Text('Update Blog Category',
                        style: TextStyle(color: Colors.white)),
                    centerTitle: true, // This centers the title
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context); // Optionally navigate back
                      },
                    ),
                  ))
          ),
          Positioned(
            top: 135,
            left: 16,
            right: 16,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Category',
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
                  final updateBlogCategoryModel = UpdateBlogCategoryModel(
                    oldBlogCategory: oldBlogCategory,
                    newBlogCategory: titleController.text,
                    newSlug: slugController.text,
                  );

                  bool success = await blogCategoryUpdateController.updateBlogCategory(updateBlogCategoryModel);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Blog category updated successfully'),
                      backgroundColor: Colors.green,
                    ));
                    Navigator.pop(context); // Optionally navigate back
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to update blog category'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Update',
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
