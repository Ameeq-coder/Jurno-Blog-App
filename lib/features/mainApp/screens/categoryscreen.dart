import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junorno_news/constants/colors.dart';
import 'package:junorno_news/features/UserApp/Screens/userhome.dart';
import 'package:junorno_news/features/mainApp/screens/creatorhome.dart';
import 'package:junorno_news/features/mainApp/screens/TagsScreen.dart';

import '../controllers/CategoryController .dart';

class CategorySelectionScreen extends StatefulWidget {
  final String userId;

  CategorySelectionScreen({super.key, required this.userId});




  @override
  _CategorySelectionScreenState createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  final CategoryController _categoryController = CategoryController(); // Instance of the controller
  List<String> selectedCategories = [];

  void onCategorySelected(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
    });
  }
  Future<void> _updateCategories() async {
    bool success = await _categoryController.updateCategories(widget.userId, selectedCategories);
    if (success) {
      Get.snackbar('Success', 'Categories updated successfully!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar('Error', 'Failed to update categories.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset('assets/images/categorylogo.png', height: 50),
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            top: 150,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please select the categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 5),
                Text(
                  'Note: You can customize your categories',
                  style: TextStyle(
                    fontSize: 14,
                    color: TColors.categorytextcolor,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  'from feed too.',
                  style: TextStyle(
                    fontSize: 14,
                    color: TColors.categorytextcolor,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
          Positioned(
            top: 250,
            left: 20,
            right: 20,
            child: Wrap(
              spacing: 10,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                CategoryButton('Ancient', onSelect: _toggleCategory),
                CategoryButton('Nature', onSelect: _toggleCategory),
                CategoryButton('Tech', onSelect: _toggleCategory),
                CategoryButton('Artificial Intelligence', onSelect: _toggleCategory),
                CategoryButton('Science', onSelect: _toggleCategory),
                CategoryButton('Sports', onSelect: _toggleCategory),
                CategoryButton('Coding', onSelect: _toggleCategory),
                CategoryButton('Movies', onSelect: _toggleCategory),


              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed:() async{
                await _updateCategories();
                Get.to(()=>UserHome());
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }


}




class CategoryButton extends StatefulWidget {
  final String title;
  final Function(String) onSelect; // Callback to notify the parent of selection

  CategoryButton(this.title, {required this.onSelect});

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelect(widget.title); // Notify parent of selection
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? TColors.primary : Colors.white, // Change color when selected
          border: Border.all(color: TColors.primary, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : TColors.primary, // Change text color when selected
          ),
        ),
      ),
    );
  }
}



