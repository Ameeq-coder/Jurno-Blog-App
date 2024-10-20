import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junorno_news/features/mainApp/controllers/UpdatePostController.dart';
import 'package:junorno_news/features/mainApp/screens/ChannelProfile.dart';
import '../../../constants/colors.dart';
import '../models/UpdatePostModel.dart';
import 'SelectBlogTagScreen.dart';
import 'categroy_selectscreen.dart';
import 'widgets/bottomnavigation.dart';

class UpdatePostScreen extends StatefulWidget {
  final String postId;

  UpdatePostScreen({required this.postId});

  @override
  _UpdatePostScreenState createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController slugController = TextEditingController();
  final storage = FlutterSecureStorage();
  List<String> selectedTags = [];
  List<String> selectedCategories = [];
  File? _imageFile;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();
  final QuillController postController = QuillController.basic();
  final UpdatePostController _postController = UpdatePostController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPostData();

  }

  void _fetchPostData() async {
    try {
      final post = await _postController.getPostById(widget.postId);
      if (post != null) {
        setState(() {
          titleController.text = post.title;
          slugController.text = post.slug;
          selectedTags = post.tags ?? [];
          selectedCategories = post.categories ?? [];

          if (post.content != null && post.content.isNotEmpty) {
            if (_isValidJson(post.content)) {
              postController.document = Document.fromJson(jsonDecode(post.content));
            } else {
              postController.document = Document()..insert(0, post.content);
            }
          }

          // Store the image URL instead of assigning it as a File
          if (post.featuredImage != null && post.featuredImage!.isNotEmpty) {
            _imageUrl = post.featuredImage;  // Store the image URL
          }
        });
      }
    } catch (e) {
      print("Error fetching post data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }



  bool _isValidJson(String input) {
    try {
      jsonDecode(input);
      return true;
    } catch (e) {
      return false;
    }
  }







  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
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



  Future<void> _updatePost() async {
    final postData = UpdatePostModel(

      title: titleController.text,
      slug: slugController.text,
      tags: selectedTags,
      categories: selectedCategories,
      content: jsonEncode(postController.document.toDelta().toJson()),
      id: widget.postId,
    );

    // Update post with the selected image (if any)
    bool success = await _postController.updatePost(widget.postId, postData, _imageFile);
    if (success) {
      Get.snackbar('Success', 'Post updated successfully');
      Get.to(ChannelProfileScreen());
    } else {
      Get.snackbar('Error', 'Failed to update the post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Update Post', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: TColors.primary,
        actions: [
          IconButton(
            onPressed: _updatePost,
            icon: Icon(Icons.check, color: Colors.white),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                    child: _imageUrl == null || _imageUrl!.isEmpty
                        ? Image.asset('assets/images/featuredposts.PNG')  // Default image when no URL is available
                        : Image.network(
                      _imageUrl!,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/featuredposts.PNG');  // Fallback to default image if the network image fails
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: slugController,
                decoration: InputDecoration(
                  hintText: 'Slug',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              // Tags Section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
                        .map((tag) => Chip(label: Text(tag)))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Categories Section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
                        .map((category) => Chip(label: Text(category)))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              QuillToolbar.simple(
                  configurations: QuillSimpleToolbarConfigurations(
                      controller: postController,
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
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 250,
                    child: QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                          controller: postController,
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
    );
  }
}
