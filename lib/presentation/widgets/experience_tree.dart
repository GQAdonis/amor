import 'package:amor/presentation/layout/adaptive.dart';
import 'package:amor/presentation/widgets/tree_painter.dart';
import 'package:amor/values/values.dart';
import 'package:flutter/material.dart';
import 'package:amor/utils/functions.dart';
import 'package:amor/presentation/widgets/spaces.dart';

import 'experience_section.dart';

class ExperienceTree extends StatelessWidget {
  ExperienceTree({
    required this.experienceData,
    required this.headTitle,
    required this.tailTitle,
    this.head,
    this.widthOfTree = 200,
    this.headTitleStyle,
    this.tailTitleStyle,
    this.tail,
    this.headBackgroundColor,
    this.tailBackgroundColor,
    this.scrollController,
  });

  final Widget? head;
  final double widthOfTree;
  final String headTitle;
  final String tailTitle;
  final TextStyle? headTitleStyle;
  final TextStyle? tailTitleStyle;
  final Color? headBackgroundColor;
  final Color? tailBackgroundColor;
  final Widget? tail;
  final List<ExperienceData> experienceData;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      child: ListView(
        controller: scrollController,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(Sizes.PADDING_8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.RADIUS_20),
                color: headBackgroundColor ??
                    AppColors.primaryColor.withOpacity(0.6),
              ),
              child: Text(
                headTitle,
                style: headTitleStyle ??
                    textTheme.subtitle1?.copyWith(color: AppColors.accentColor),
              ),
            ),
          ),
          Column(
            children: _buildExperienceBranches(
              context: context,
              experienceData: experienceData,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(Sizes.PADDING_8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.RADIUS_20),
                color: tailBackgroundColor ??
                    AppColors.primaryColor.withOpacity(0.6),
              ),
              child: Text(
                tailTitle,
                style: tailTitleStyle ??
                    textTheme.subtitle1?.copyWith(color: AppColors.accentColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildExperienceBranches({
    required BuildContext context,
    required List<ExperienceData> experienceData,
  }) {
    List<Widget> branchWidgets = [];
    for (var index = 0; index < experienceData.length; index++) {
      branchWidgets.add(
        ExperienceBranch(
          company: experienceData[index].company,
          companyUrl: experienceData[index].companyUrl,
          position: experienceData[index].position,
          roles: experienceData[index].roles,
          location: experienceData[index].location,
          duration: experienceData[index].duration,
          width: widthOfTree,
          height: isDisplaySmallDesktop(context)
              ? assignHeight(context, 0.45)
              : assignHeight(context, 0.35),
        ),
      );
    }

    return branchWidgets;
  }
}

class ExperienceBranch extends StatefulWidget {
  ExperienceBranch({
    required this.location,
    required this.duration,
    required this.company,
    required this.position,
    required this.roles,
    required this.companyUrl,
    this.width = 200,
    this.height = 200,
    this.customPainter,
    this.stalk = 0.1,
  });

  final double width;
  final double stalk;
  final double height;
  final String company;
  final String companyUrl;
  final String location;
  final String duration;
  final String position;
  final List<String> roles;
  final CustomPainter? customPainter;

  @override
  _ExperienceBranchState createState() => _ExperienceBranchState();
}

class _ExperienceBranchState extends State<ExperienceBranch> {
  GlobalKey roleLeafKey = GlobalKey();
  GlobalKey locationLeafKey = GlobalKey();
  double offsetRoleLeaf = 0.0;
  double offsetLocationLeaf = 0.0;

  @override
  void initState() {
    offsetRoleLeaf = (widget.height / 5) - 10;
    offsetLocationLeaf = (widget.height / 2) - 16;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getHeightOfRoleLeaf();
    });
    super.initState();
  }

  _getHeightOfRoleLeaf() {
    final RenderBox roleLeafRenderBox =
        roleLeafKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox locationLeafRenderBox =
        locationLeafKey.currentContext?.findRenderObject() as RenderBox;

    final roleLeafHeight = roleLeafRenderBox.size.height;
    final locationLeafHeight = locationLeafRenderBox.size.height;
    setState(() {
      offsetRoleLeaf = (widget.height / 2) - (roleLeafHeight / 2);
      offsetLocationLeaf = (widget.height / 2) - (locationLeafHeight / 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: widget.customPainter ??
          TreePainter(
            stalk: 0.1,
            veinsColor: AppColors.primaryColor.withOpacity(0.6),
            outerJointColor: AppColors.primaryColor.withOpacity(0.6),
            innerJointColor: AppColors.primaryColor,
          ),
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            Positioned(
              width: widget.width / 2,
              top: offsetLocationLeaf,
              left: 0,
              child: Container(
                key: locationLeafKey,
                padding: EdgeInsets.only(right: (widget.width * widget.stalk)),
                child: LocationDateLeaf(
                  duration: widget.duration,
                  location: widget.location,
                ),
              ),
            ),
            SpaceH8(),
            Positioned(
              width: widget.width / 2,
              top: offsetRoleLeaf,
              right: 0,
              child: Container(
                key: roleLeafKey,
                padding: EdgeInsets.only(
                  left: (widget.width * widget.stalk),
                ),
                child: RoleLeaf(
                  company: widget.company,
                  onTap: () {
                    openUrlLink(widget.companyUrl);
                  },
                  position: widget.position,
                  roles: widget.roles,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LocationDateLeaf extends StatelessWidget {
  LocationDateLeaf({
    required this.duration,
    required this.location,
    this.durationIcon,
    this.locationIcon,
    this.locationTextStyle,
    this.durationTextStyle,
  });

  final String duration;
  final String location;
  final TextStyle? durationTextStyle;
  final TextStyle? locationTextStyle;
  final Icon? locationIcon;
  final Icon? durationIcon;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                duration,
                style: durationTextStyle ??
                    textTheme.bodyText2
                        ?.copyWith(color: AppColors.primaryColor100),
              ),
              SpaceW4(),
              durationIcon ??
                  Icon(
                    Icons.access_time,
                    color: AppColors.accentColor,
                    size: 18,
                  ),
            ],
          ),
          SpaceH8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                location,
                style: locationTextStyle ??
                    textTheme.bodyText2?.copyWith(color: AppColors.primaryText),
              ),
              SpaceW4(),
              locationIcon ??
                  Icon(
                    Icons.location_on,
                    color: AppColors.accentColor,
                    size: 18,
                  ),
            ],
          )
        ],
      ),
    );
  }
}

class RoleLeaf extends StatelessWidget {
  RoleLeaf({
    required this.company,
    required this.position,
    required this.roles,
    this.companyTextStyle,
    this.positionTextStyle,
    this.roleTextStyle,
    this.onTap,
  });

  final String company;
  final String position;
  final List<String> roles;
  final TextStyle? companyTextStyle;
  final TextStyle? positionTextStyle;
  final TextStyle? roleTextStyle;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: Text(
              company,
              style: companyTextStyle ??
                  textTheme.subtitle1?.copyWith(
                    fontSize: Sizes.TEXT_SIZE_18,
                    color: AppColors.accentColor,
                  ),
            ),
          ),
          Text(
            position,
            style: positionTextStyle ??
                textTheme.subtitle2?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.accentColor,
                ),
          ),
          SpaceH8(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildRoles(roles: roles, context: context),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRoles({
    required List<String> roles,
    required BuildContext context,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<Widget> roleWidgets = [];
    for (var index = 0; index < roles.length; index++) {
      roleWidgets.add(
        Role(
          role: roles[index],
          roleTextStyle: roleTextStyle ??
              textTheme.bodyText2?.copyWith(color: AppColors.primaryText),
          color: AppColors.primaryColor,
        ),
      );
      roleWidgets.add(SpaceH8());
    }

    return roleWidgets;
  }
}
