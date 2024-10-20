import 'package:flutter/material.dart';
import 'package:junorno_news/utils/constants/text_strings.dart';

class FrontPageTexts extends StatelessWidget {
  const FrontPageTexts({
    super.key,
  });

  @override

  Widget build(BuildContext context) {
    return Positioned(
      bottom: 200, // Adjust to position the text vertically as needed
      left: 20, // Adjust to position the text horizontally as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.Maintext1,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            TTexts.MainText2,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
