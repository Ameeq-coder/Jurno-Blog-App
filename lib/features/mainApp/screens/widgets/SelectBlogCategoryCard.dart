import 'package:flutter/material.dart';
import 'package:junorno_news/features/mainApp/models/BlogCategoryModel.dart';

import '../../models/BlogCategoryModel.dart';


class SelectBlogCategoryCard extends StatelessWidget {
  final BlogCategoryModel blogCategoryModel;
  final int index;
  final bool isSelected;
  final ValueChanged<bool?> onCheckboxChanged;

  SelectBlogCategoryCard({
    required this.blogCategoryModel,
    required this.index,
    required this.isSelected,
    required this.onCheckboxChanged,
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
            Checkbox(
              value: isSelected,
              onChanged: onCheckboxChanged,
            ),
          ],
        ),
      ),
    );
  }
}
