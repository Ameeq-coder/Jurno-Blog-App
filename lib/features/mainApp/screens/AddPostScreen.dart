import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junorno_news/features/mainApp/screens/ChannelProfile.dart';

import 'package:junorno_news/features/mainApp/screens/SelectBlogTagScreen.dart';
import 'package:junorno_news/features/mainApp/screens/categroy_selectscreen.dart';
import 'package:junorno_news/features/mainApp/screens/widgets/bottomnavigation.dart';

import '../../../constants/colors.dart';
import '../controllers/PostController.dart';
import '../models/PostModel.dart';

class AddPostScreen extends StatefulWidget {
  final List<String> selectedTags;
  final List<String> selectedCategories;

  AddPostScreen({required this.selectedTags, required this.selectedCategories});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController slugcontroller = TextEditingController();
  final storage = FlutterSecureStorage();
  late List<String> selectedTags;
  late List<String> selectedCategories;
  File? _imageFile;
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();
  final QuillController postcontroller = QuillController.basic();
  final PostController _postController = PostController();

  // Track the index of the bottom navigation

  @override
  void initState() {
    super.initState();
    selectedTags = widget.selectedTags;
    selectedCategories = widget.selectedCategories;
  }

  void _updateSelectedTags(List<String> tags) {
    setState(() {
      selectedTags = tags;
    });
  }

  void _updateSelectedCategories(List<String> categories) {
    setState(() {
      selectedCategories = categories;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _savePost() async {
    String? userId = await storage.read(key: 'channel_id');
    if (userId != null) {
      final content = jsonEncode(postcontroller.document.toDelta().toJson());
      final post = PostModel(
        userId: userId,
        title: titlecontroller.text,
        slug: slugcontroller.text,
        categories: selectedCategories,
        tags: selectedTags,
        content: content,
        featuredImage: _imageFile?.path ?? '',
      );

      final success = await _postController.addPost(post, _imageFile);

      if (success) {
        Get.snackbar('Success', 'Post saved successfully');
        Get.to(ChannelProfileScreen());
      } else {
        Get.snackbar('Error', 'Failed to save post');
      }
    } else {
      print("User ID not found");
    }
  }

  // Handle bottom navigation item tap

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Posts', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: TColors.primary,
        actions: [
          IconButton(
            onPressed: _savePost,
            icon: Icon(Icons.check, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: _imageFile == null
                        ? Image.asset('assets/images/featuredposts.PNG')
                        : Image.file(_imageFile!),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: slugcontroller,
                decoration: InputDecoration(
                  hintText: 'Slug',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                child: ListTile(
                  title: Text('Tags'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    String? userId = await storage.read(key: 'channel_id');
                    if (userId != null) {
                      final result = await Get.to(() => SelectBlogTagScreen(userId: userId));
                      if (result != null) {
                        _updateSelectedTags(result as List<String>);
                      }
                    } else {
                      print("User ID not found");
                    }
                  },
                  subtitle: selectedTags.isEmpty
                      ? Text('No tags selected')
                      : Wrap(
                    spacing: 8.0,
                    children: selectedTags
                        .map((tag) => Chip(
                      label: Text(
                        tag,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.orange,
                    ))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                child: ListTile(
                  title: Text('Categories'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    String? userId = await storage.read(key: 'channel_id');
                    if (userId != null) {
                      final result = await Get.to(() => SelectBlogCategoryScreen(userId: userId));
                      if (result != null) {
                        _updateSelectedCategories(result as List<String>);
                      }
                    } else {
                      print("User ID not found");
                    }
                  },
                  subtitle: selectedCategories.isEmpty
                      ? Text('No categories selected')
                      : Wrap(
                    spacing: 8.0,
                    children: selectedCategories
                        .map((category) => Chip(
                      label: Text(
                        category,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.orange,
                    ))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              QuillToolbar.simple(
                  configurations: QuillSimpleToolbarConfigurations(
                      controller: postcontroller,
                      multiRowsDisplay: true,
                      showUndo: true,
                      showRedo: true,
                      showAlignmentButtons: true,
                      showHeaderStyle: true,
                      showListBullets: true,
                      showListCheck: false,
                      showListNumbers: true,
                      showCodeBlock: false,
                      showInlineCode: false,
                      showLink: false,
                      showIndent: false,
                      showSearchButton: true,
                      showDirection: false,
                      sharedConfigurations: const QuillSharedConfigurations())),
              SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 250,
                    child: QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                          controller: postcontroller,
                          scrollable: true,
                          autoFocus: false,
                          placeholder: 'Write your post here...',
                          expands: true,
                          padding: EdgeInsets.zero,
                          sharedConfigurations: const QuillSharedConfigurations()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Implement the BottomNavigationBar
      bottomNavigationBar: BottomNavBarWidget(currentIndex: 2),  // Use the widget here
    );
  }
}
