import 'package:flutter/material.dart';
import '../../models/TagModel.dart';

class SelectTagCard extends StatelessWidget {
  final TagModel tagModel;
  final int index;
  final bool isSelected;
  final ValueChanged<bool?> onCheckboxChanged;

  SelectTagCard({
    required this.tagModel,
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
              child: Text(tagModel.tag),
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
