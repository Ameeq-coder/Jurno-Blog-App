import 'package:flutter/material.dart';
import 'package:junorno_news/constants/colors.dart';

class OrangeTopContainer extends StatelessWidget {
  const OrangeTopContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: 250,
        child: Container(
          color: TColors.primary,
        ));
  }
}