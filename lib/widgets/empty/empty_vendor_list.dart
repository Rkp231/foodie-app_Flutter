import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_images.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/search.strings.dart';
import 'package:foodie/translations/general.i18n.dart';

class EmptyVendor extends StatefulWidget {
  const EmptyVendor({Key key}) : super(key: key);

  @override
  _EmptyVendorState createState() => _EmptyVendorState();
}

class _EmptyVendorState extends State<EmptyVendor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        
        children: <Widget>[
          Image.asset(
            AppImages.emptySearch,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Center(
            child: Text(
              SearchStrings.emptyTitle.i18n,
              style: AppTextStyle.h4TitleTextStyle(
                color: AppColor.textColor(context),
              ),
              
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              SearchStrings.emptyBody.i18n,
              style: AppTextStyle.h5TitleTextStyle(
                color: AppColor.textColor(context),
              ),
              textAlign: TextAlign.center,
              
            ),
          ),
        ],
      ),
    );
  }
}
