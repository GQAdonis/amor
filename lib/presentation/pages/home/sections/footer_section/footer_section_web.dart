import 'package:amor/presentation/layout/adaptive.dart';
import 'package:amor/presentation/widgets/social_icons.dart';
import 'package:amor/presentation/widgets/spaces.dart';
import 'package:amor/utils/functions.dart';
import 'package:flutter/cupertino.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amor/values/values.dart';
import 'package:flutter/material.dart';

const kSpacing20 = Sizes.SIZE_20;

class FooterSectionWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? footerTextStyle = textTheme.bodyText1?.copyWith(
      fontSize: Sizes.TEXT_SIZE_12,
      color: AppColors.accentColor500,
    );
    TextStyle? linkStyle = textTheme.bodyText1?.copyWith(
      fontSize: Sizes.TEXT_SIZE_12,
      color: AppColors.white,
      decoration: TextDecoration.underline,
    );

    return Container(
      width: widthOfScreen(context),
      height: heightOfScreen(context) * 0.2,
      padding: const EdgeInsets.only(
        left: Sizes.PADDING_40,
        right: Sizes.PADDING_40,
        bottom: Sizes.PADDING_24,
      ),
      color: AppColors.purple500,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConst.RIGHTS_RESERVED,
                style: textTheme.bodyText1?.copyWith(
                  fontSize: Sizes.TEXT_SIZE_12,
                  color: AppColors.accentColor500,
                ),
              ),
              SpaceH2(),
              Row(
                children: [
                  InkWell(
                    onTap: () => openUrlLink(StringConst.DAVID_LEGEND_URL),
                    child: RichText(
                      text: TextSpan(
                        style: footerTextStyle,
                        text: "${StringConst.BUILT_BY} ",
                        children: [
                          TextSpan(
                            text: "${StringConst.DAVID_COBBINA}, ",
                            style: linkStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => openUrlLink(StringConst.DESIGN_URL),
                    child: RichText(
                      text: TextSpan(
                        text: "${StringConst.DESIGNED_BY} ",
                        style: footerTextStyle,
                        children: [
                          TextSpan(
                            text: "${StringConst.ADEEL_RAZA}.",
                            style: linkStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SpaceH2(),
              Row(
                children: [
                  Text(
                    StringConst.MADE_IN_GHANA,
                    style: footerTextStyle,
                  ),
                  SpaceW4(),
                  ClipRRect(
                    borderRadius: BorderRadius.all(const Radius.circular(20)),
                    child: Image.asset(
                      ImagePath.GHANA_FLAG,
                      width: Sizes.WIDTH_16,
                      height: Sizes.HEIGHT_16,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SpaceW4(),
                  Text(
                    " ${StringConst.WITH_LOVE}",
                    style: footerTextStyle,
                  ),
                  SpaceW4(),
                  Icon(
                    FontAwesomeIcons.solidHeart,
                    color: AppColors.red,
                    size: Sizes.ICON_SIZE_12,
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          SocialIcons(
            iconColor: AppColors.accentColor500,
            icons: [
              FontAwesomeIcons.linkedin,
              FontAwesomeIcons.github,
              FontAwesomeIcons.twitter,
            ],
            socialLinks: [
              StringConst.LINKED_IN_URL,
              StringConst.GITHUB_URL,
              StringConst.TWITTER_URL,
            ],
            spacing: kSpacing20,
          )
        ],
      ),
    );
  }
}