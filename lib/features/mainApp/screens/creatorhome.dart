import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/CreatorPostController.dart';
import 'widgets/bottomnavigation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CreatorPostController _creatorPostController = Get.put(CreatorPostController());
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Carousel Slider for Post Images
          Positioned(
            top: 35,
            left: 16,
            right: 16,
            child: Obx(() {
              if (_creatorPostController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (_creatorPostController.postList.isEmpty) {
                return Center(
                  child: Text(
                    'No Posts Found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        itemCount: _creatorPostController.postList.length,
                        itemBuilder: (BuildContext context, int index, int realIndex) {
                          return Image.network(
                            _creatorPostController.postList[index].image,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  AnimatedSmoothIndicator(
                    activeIndex: _currentIndex,
                    count: _creatorPostController.postList.length,
                    effect: ScrollingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotScale: 1.3,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.orange,
                    ),
                  ),
                ],
              );
            }),
          ),

          // Latest Posts Section
          Positioned(
            top: 270,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latest Posts',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Inter',
                      color: Colors.black),
                ),
              ],
            ),
          ),

          // Latest Posts List
          Positioned(
            top: 310,
            left: 16,
            right: 16,
            bottom: 80,
            child: Obx(() {
              if (_creatorPostController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: _creatorPostController.postList.length,
                itemBuilder: (context, index) {
                  final post = _creatorPostController.postList[index];
                  String formattedDate = DateFormat('dd MMM yyyy').format(post.date);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(post.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins'),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Row(

                                children: [
                                  Icon(Icons.access_time_outlined),
                                  Padding(padding: EdgeInsets.only(right: 6)),
                                  Text(formattedDate),
                                ],
                              ),
                              SizedBox(height: 3),
                              Text(
                                '${post.views} Views',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),

          // Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBarWidget(currentIndex: 0),
          ),
        ],
      ),
    );
  }
}
