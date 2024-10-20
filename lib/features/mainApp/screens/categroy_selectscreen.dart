import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/mainApp/controllers/BlogCategoryController.dart';
import 'package:junorno_news/features/mainApp/models/BlogCategoryModel.dart';

class SelectBlogCategoryScreen extends StatefulWidget {
  final String userId;

  SelectBlogCategoryScreen({required this.userId});

  @override
  _SelectBlogCategoryScreenState createState() => _SelectBlogCategoryScreenState();
}

class _SelectBlogCategoryScreenState extends State<SelectBlogCategoryScreen> {
  late Future<List<BlogCategoryModel>> _blogCategoriesFuture;
  final Map<String, bool> selectedCategories = {};

  @override
  void initState() {
    super.initState();
    _blogCategoriesFuture = BlogCategoryController(widget.userId).fetchBlogCategories();
  }

  void _onTickPressed() {
    final selected = selectedCategories.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();
    Get.back(result: selected); // Pass selected categories back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Categories for Post',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: TColors.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: _onTickPressed,
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
            blogCategories.forEach((category) {
              if (!selectedCategories.containsKey(category.blogcategory)) {
                selectedCategories[category.blogcategory] = false;
              }
            });

            return ListView.builder(
              itemCount: blogCategories.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final category = blogCategories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Card(
                    child: ListTile(
                      title: Text(category.blogcategory),
                      trailing: Checkbox(
                        value: selectedCategories[category.blogcategory],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedCategories[category.blogcategory] = value!;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
