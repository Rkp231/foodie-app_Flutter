import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/viewmodels/vendor_page.viewmodel.dart';

class VendorPageAppBar extends StatelessWidget {
  final VendorPageViewModel model;
  const VendorPageAppBar({
    this.model,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.transparent,
      backgroundColor: model.makeAppBarTransparent ? Colors.transparent : null,
      elevation: 0,
      leading: TextButton(
        child: Icon(
          Icons.arrow_back_ios,
          color: model.makeAppBarTransparent
              ? AppColor.primaryColorDark
              : Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      bottom: model.makeAppBarTransparent
          ? null
          : TabBar(
              labelColor: AppColor.textColor(
                context,
                inverse: true,
              ),
              unselectedLabelColor:
                  AppColor.bottomNavigationItemUnselectedColor(context),
              isScrollable: true,
              indicatorWeight: 4.0,
              indicatorPadding: EdgeInsets.all(0),
              indicatorColor: AppColor.accentColor,
              labelStyle: AppTextStyle.h4TitleTextStyle(),
              unselectedLabelStyle: AppTextStyle.h5TitleTextStyle(),
              tabs: model.menus.map(
                (menu) {
                  return Tab(
                    text: menu.name,
                  );
                },
              ).toList(),
            ),
    );
  }
}
