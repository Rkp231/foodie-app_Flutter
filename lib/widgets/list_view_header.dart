import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/utils/ui_spacer.dart';

class ListViewHeader extends StatelessWidget {
  const ListViewHeader({
    Key key,
    this.title,
    this.subTitle,
    this.iconData,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: <Widget>[
        Icon(
          this.iconData,
          color: AppColor.textColor(context),
        ),
        UiSpacer.horizontalSpace(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            
            children: <Widget>[
              Text(
                this.title,
                style: AppTextStyle.h4TitleTextStyle(
                  color: AppColor.textColor(context),
                ),
                
              ),
              Text(
                this.subTitle,
                style: AppTextStyle.h5TitleTextStyle(
                  fontWeight: FontWeight.w300,
                  color: AppColor.hintTextColor(context),
                ),
                
              ),
            ],
          ),
        ),
      ],
    );
  }
}
