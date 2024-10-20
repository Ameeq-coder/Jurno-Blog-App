import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/mainApp/controllers/DeleteTagController.dart';
import 'package:junorno_news/features/mainApp/models/TagModel.dart';
import 'package:junorno_news/features/mainApp/controllers/TagController.dart';
import 'package:junorno_news/features/mainApp/screens/AddTags.dart';
import 'package:junorno_news/features/mainApp/screens/UpdateTagScreen.dart';
import 'package:junorno_news/features/mainApp/screens/widgets/TagCard.dart';
import 'package:junorno_news/features/mainApp/screens/widgets/bottomnavigation.dart';

class TagManagementScreen extends StatefulWidget {
  final String userId;

  TagManagementScreen({required this.userId});

  @override
  _TagManagementScreenState createState() => _TagManagementScreenState();
}

class _TagManagementScreenState extends State<TagManagementScreen> {
  late Future<List<TagModel>> _tagsFuture;
  late Tagcontroller _tagControllerInstance;
  late DelteTagController _deleteTagControllerInstance;

  @override
  void initState() {
    super.initState();
    _tagControllerInstance = Tagcontroller(widget.userId);
    _tagsFuture = _tagControllerInstance.fetchTags();
    _deleteTagControllerInstance = DelteTagController();
  }

  void _refreshTags() {
    setState(() {
      _tagsFuture = _tagControllerInstance.fetchTags();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tags',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: TColors.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => Get.to(() => AddTagScreen(
              onTagAdded: _refreshTags,
            )),
          ),
        ],
      ),
      body: FutureBuilder<List<TagModel>>(
        future: _tagsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tags available.'));
          } else {
            final tags = snapshot.data!;
            return ListView.builder(
              itemCount: tags.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: TagCard(
                    tagModel: tags[index],
                    index: index,
                    onEdit: () {
                      Get.to(() => Updatetagscreen(
                        oldTag: tags[index].tag,
                        oldSlug: tags[index].slug,
                      ))!.then((_) => _refreshTags());
                    },
                    onDelete: () async {
                      try {
                        bool success = await _deleteTagControllerInstance.deleteTag(tags[index].tag);
                        if (success) {
                          _refreshTags();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Tag deleted successfully'))
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to delete tag: $e'))
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
      bottomNavigationBar: BottomNavBarWidget(currentIndex: 1),  // Use the widget here
    );
  }
}
