import 'package:flutter/material.dart';

class BuildCoverImage extends StatelessWidget {
  final double coverHeight;
  const BuildCoverImage({Key? key,
    required this.coverHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Image.asset(
         ' ',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover
      ),
    );
  }
}