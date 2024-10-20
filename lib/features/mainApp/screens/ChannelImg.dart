import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/ChannelDescriptionCreationController.dart';

class ChannelImageUploadScreen extends StatefulWidget {
  @override
  _ChannelImageUploadScreenState createState() =>
      _ChannelImageUploadScreenState();
}

class _ChannelImageUploadScreenState extends State<ChannelImageUploadScreen> {
  File? _image; // Holds the image file
  final TextEditingController _descriptionController = TextEditingController();
  final ChannelDescriptionCreationController _channelController = Get.put(ChannelDescriptionCreationController());

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100),
                // Space for stack positioning
                Center(
                  child: GestureDetector(
                    onTap: _pickImage, // Tap to upload image
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              _image != null ? FileImage(_image!) : null,
                        ),
                        if (_image == null)
                          Icon(Icons.add_a_photo,
                              color: Colors.grey[700], size: 40),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  "Add Image For Your Channel",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25
                  ),
                ),
                SizedBox(height: 20),
                // Card for description input
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Add Channel Description',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _descriptionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Enter your channel description...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 150),
                // To push the button to the bottom of the screen
              ],
            ),
          ),
          // Submit button positioned at the bottom
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
             child: Obx(() => ElevatedButton(
              onPressed: () {
                if (!_channelController.isLoading.value) {
                  _channelController.updateChannel( _descriptionController.text, _image);
                }
              },
              child: _channelController.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Submit', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            )),
          ),
          // Positioned widget for circular avatar adjustment
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Back button
              },
            ),
          ),
        ],
      ),
    );
  }
}
