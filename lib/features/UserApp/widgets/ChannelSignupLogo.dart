import 'package:flutter/widgets.dart';

class ChannelSignupLogo extends StatelessWidget {
  const ChannelSignupLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 0,
      right: 0,
      child: Column(
        children: [
          // Replace with your logo image asset
          Image.asset(
            'assets/images/logo.png',
            height: 100,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
