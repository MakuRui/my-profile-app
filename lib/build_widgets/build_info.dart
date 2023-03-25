import 'package:flutter/material.dart';

class BuildInfo extends StatelessWidget {
  final String infoType;
  final String info;
  const BuildInfo({Key? key,
    required this.infoType,
    required this.info
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widthSize,
      child: Row(
        children: [
          SizedBox(
              width: widthSize / 4,
              child: Text(infoType)),
          const SizedBox(width: 100,),
          Text(info),
        ],
      ),
    );
  }
}
