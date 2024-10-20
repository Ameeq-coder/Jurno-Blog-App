import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/mainApp/controllers/TagController.dart';
import 'package:junorno_news/features/mainApp/models/TagModel.dart';
import 'package:junorno_news/features/mainApp/screens/AddPostScreen.dart';
import 'package:junorno_news/features/mainApp/screens/AddTags.dart';
import 'package:junorno_news/features/mainApp/screens/widgets/SelectBlogTagCard.dart';
import 'package:junorno_news/features/mainApp/screens/widgets/TagCard.dart';

class SelectBlogTagScreen extends StatefulWidget {
  final String userId;

  SelectBlogTagScreen({required this.userId});

  @override
  _SelectBlogTagScreenState createState() => _SelectBlogTagScreenState();
}

class _SelectBlogTagScreenState extends State<SelectBlogTagScreen> {
  late Future<List<TagModel>> _tagsFuture;
  late Tagcontroller _tagControllerInstance;

  Map<String, bool> selectedTags = {};

  @override
  void initState() {
    super.initState();
    _tagControllerInstance = Tagcontroller(widget.userId);
    _tagsFuture = _tagControllerInstance.fetchTags();
  }

  void _refreshTags() {
    setState(() {
      _tagsFuture = _tagControllerInstance.fetchTags();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Tags for Post',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: TColors.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: () {
              final selectedTagsList = selectedTags.keys
                  .where((tag) => selectedTags[tag] == true)
                  .toList();
              Get.back(result: selectedTagsList);
            },
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
                final tag = tags[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: SelectTagCard(
                    tagModel: tag,
                    index: index,
                    isSelected: selectedTags[tag.tag] ?? false,
                    onCheckboxChanged: (bool? value) {
                      setState(() {
                        selectedTags[tag.tag] = value!;
                      });
                    },
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
