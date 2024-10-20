import 'package:flutter/material.dart';
import 'package:junorno_news/utils/constants/image_strings.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      left: 0,
      right: 0,
      child: Center(
        child: Image.asset(
          TImages.logo,
          height: 100, // Adjust the height as needed
        ),
      ),
    );
  }
}
