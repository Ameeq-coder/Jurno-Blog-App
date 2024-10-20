import 'package:flutter/cupertino.dart';

import '../../../constants/colors.dart';

class BlackTopContainer extends StatelessWidget {
  const BlackTopContainer({
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
          color: TColors.darkcolor,
        ));
  }
}