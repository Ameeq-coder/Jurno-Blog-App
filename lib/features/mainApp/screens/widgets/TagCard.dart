import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/TagModel.dart';

class TagCard extends StatelessWidget {
  final TagModel tagModel;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  TagCard({required this.tagModel, required this.index, required this.onEdit, required this.onDelete});

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
              child: Text(tagModel.tag),
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