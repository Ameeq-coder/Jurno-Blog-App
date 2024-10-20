import 'package:flutter/material.dart';

import '../../models/BlogCategoryModel.dart';

class BlogCategoryCard extends StatelessWidget {
  final BlogCategoryModel blogCategoryModel;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  BlogCategoryCard({
    required this.blogCategoryModel,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text('${index + 1}'),
            SizedBox(width: 10),
            Expanded(
              child: Text(blogCategoryModel.blogcategory),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.green),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete, // Handle delete action
            ),
          ],
        ),
      ),
    );
  }
}
