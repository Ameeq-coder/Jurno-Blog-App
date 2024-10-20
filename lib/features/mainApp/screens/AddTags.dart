import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/mainApp/controllers/AddTagController.dart';

class AddTagScreen extends StatelessWidget {
  final VoidCallback onTagAdded;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController slugController = TextEditingController();
  final Addtagcontroller tagController = Addtagcontroller();

  AddTagScreen({super.key, required this.onTagAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background for the whole screen
      appBar: AppBar(
        backgroundColor: Colors.orange, // Orange color applied only to the AppBar
        elevation: 0,
        title: Text(
          'Add New Tags',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true, // This centers the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigates back when the back button is pressed
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
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
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
                  String title = titleController.text.trim();
                  String slug = slugController.text.trim();

                  bool success = await tagController.addTag(title, slug);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Tag and slug added/updated successfully'),
                    ));
                    onTagAdded(); // Trigger the callback to refresh tags
                    Navigator.pop(context); // Optionally navigate back
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to add/update tag and slug'),
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
