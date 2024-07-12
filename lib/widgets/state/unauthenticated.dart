import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_images.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodie/translations/home/profile.i18n.dart';

class UnauthenticatedPage extends StatefulWidget {
  UnauthenticatedPage({Key key}) : super(key: key);

  @override
  _UnauthenticatedPageState createState() => _UnauthenticatedPageState();
}

class _UnauthenticatedPageState extends State<UnauthenticatedPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //image
          Image.asset(
            AppImages.unauthenticatedImage,
            height: MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.width * 0.20,
          ),

          //title
          Text(
            "Unauthorized".i18n,
            style: AppTextStyle.h2TitleTextStyle(
              color: AppColor.textColor(context),
            ),
          ),
          //body/description
          "You must sign-in to access this section"
              .i18n
              .text
              .center
              .textStyle(AppTextStyle.h4TitleTextStyle(
                color: AppColor.textColor(context),
              ))
              .makeCentered(),

          //
          UiSpacer.verticalSpace(),
          //Login button
          CustomButton(
            color: AppColor.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              "Login".i18n,
              style: AppTextStyle.h4TitleTextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.loginOTPRoute,
              );
            },
          ),
        ],
      ),
    );
  }
}
