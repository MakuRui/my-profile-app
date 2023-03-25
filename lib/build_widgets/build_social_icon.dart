import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildSocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;
  const BuildSocialIcon({Key? key,
    required this.icon,
    required this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () async {
          Uri finalUrl = Uri.parse(url);
          if (await canLaunchUrl(finalUrl)){
            await launchUrl(
              finalUrl,
            );
          }
        },
        icon: Icon(
            icon,
            size: 32
        ),
      ),
    );
  }
}
