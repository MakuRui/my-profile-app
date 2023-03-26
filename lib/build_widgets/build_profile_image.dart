import 'package:flutter/material.dart';

class BuildProfileImage extends StatelessWidget {
  final double profileHeight;
  const BuildProfileImage({Key? key,
    required this.profileHeight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.person, size: 100,);
  }
}
