import 'package:flutter/material.dart';

class BuildProfileImage extends StatelessWidget {
  final double profileHeight;
  const BuildProfileImage({Key? key,
    required this.profileHeight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.lightBlue,
        backgroundImage: const AssetImage('assets/profile_image.jpg')
    );
  }
}
