import 'package:amor/values/values.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class SocialIcons extends StatelessWidget {
  final Color? iconColor;
  final double? size;
  final double spacing;
  final List<IconData> icons;
  final List<String> socialLinks;

  SocialIcons({
    this.iconColor = AppColors.grey200,
    this.size = Sizes.ICON_SIZE_20,
    required this.spacing,
    required this.icons,
    required this.socialLinks,
  }) : assert(icons.length == socialLinks.length);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: spacing,
        children: _buildSocialIcons(),
      ),
    );
  }

  List<Widget> _buildSocialIcons() {
    List<Widget> iconWidgets = [];

    for (var index = 0; index < icons.length; index++) {
      iconWidgets.add(
        InkWell(
          onTap: () => _openSocialLink(socialLinks[index]),
          child: Icon(
            icons[index],
            color: iconColor,
            size: size,
          ),
        ),
      );
    }

    return iconWidgets;
  }

  Future<void> _openSocialLink(String url) async {
    if (await canLaunch(url)) {
      print("URL:: $url");
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
