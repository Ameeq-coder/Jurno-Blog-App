import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:junorno_news/features/authentication/screens/Front%20Screen/front.dart';
import 'package:junorno_news/features/authentication/screens/Login/login.dart';

import '../authentication/controllers/LoginController.dart';


class OnboardingController extends GetxController{

  static OnboardingController get instance => Get.find();
  final pagecontroller= PageController();
  Rx<int> currentPageIndex=0.obs;


  void updatePageIndicator(index) => currentPageIndex.value=index;

  void dotNavigationClick(index){
    currentPageIndex.value=index;
    pagecontroller.jumpTo(index);
  }
  void nextPage(){
    if(currentPageIndex == 2){
      Get.offAll(front());
    }else{
      int page = currentPageIndex.value + 1;
      pagecontroller.jumpToPage(page);
    }
  }
  void skipPage(){
    currentPageIndex.value=2;
    pagecontroller.jumpToPage(2);
  }


}